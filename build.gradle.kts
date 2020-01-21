import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("com.github.ben-manes.versions")
    id("org.openapi.generator")
}

group = "com.crowdproj"
version = "1.0-SNAPSHOT"

allprojects {
    repositories {
        mavenCentral()
        jcenter()
    }
}

tasks {
    create<GenerateTask>("generateKotlinModels") {
        group = "openapi"
        generatorName.set("kotlin-server")
        inputSpec.set("$rootDir/spec/crowdproj-spec.yaml")
        outputDir.set("$rootDir/crowdproj-models-kt")
        modelPackage.set("${project.group}.models")
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
        configOptions.putAll(
            mutableMapOf(
                "modelMutable" to "true",
                "swaggerAnnotations" to "true"
            )
        )
        systemProperties.putAll(
            mapOf(
                "models" to "",
                "modelTests" to "",
                "modelDocs" to ""
            )
        )
    }
    val cleanKotlinModels by creating(Delete::class) {
        group = "openapi"
        val modelsKt = project(":crowdproj-models-kt").projectDir
        fileTree(modelsKt).visit {
            if (!file.name.endsWith(".kts")) {
                delete(file)
            }
        }
    }

    create<GenerateTask>("generateDartModels") {
        group = "openapi"
        generatorName.set("dart-dio")
        inputSpec.set("$rootDir/spec/crowdproj-spec.yaml")
        outputDir.set("$rootDir/crowdproj-front-private/crowdproj_models")
        packageName.set(project.group.toString())
        modelPackage.set("${project.group}.models")
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
        apiPackage.set("${project.group}.api")
        invokerPackage.set("${project.group}.invoker")
    }

    val cleanDartModels by creating(Delete::class) {
        group = "openapi"
        val modelsDart = "${project(":crowdproj-front-private").projectDir}/crowdproj_models"
        println("MODELS DART: $modelsDart")
        fileTree(modelsDart).visit {
            delete(file)
        }
    }

    create<Delete>("clean", Delete::class) {
        group = BasePlugin.BUILD_GROUP
        dependsOn(cleanDartModels)
        dependsOn(cleanKotlinModels)
    }
}
