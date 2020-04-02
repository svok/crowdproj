import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("com.github.ben-manes.versions")
    id("org.openapi.generator")
}

group = "com.crowdproj"
version = "0.0.1"

allprojects {
    repositories {
        mavenCentral()
        jcenter()
    }
}

tasks {

    val flutterBinPath: String by project

    create<GenerateTask>("generateKotlinModels") {
        val genPackage = "${project.group}.rest"
        group = "openapi"
        val spec = "$rootDir/spec/crowdproj-spec.yaml"
        val dest = "$rootDir/crowdproj-models-kt"
        inputs.files(spec)
        outputs.files(fileTree(dest))
        generatorName.set("kotlin-server")
        inputSpec.set(spec)
        outputDir.set(dest)
        modelPackage.set("$genPackage.models")
        apiPackage.set("$genPackage.apis")
        packageName.set(genPackage)
        invokerPackage.set("$genPackage.infrastructure")
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
        configOptions.putAll(
            mutableMapOf(
//                "modelMutable" to "true",
                "swaggerAnnotations" to "true"
            )
        )
//        systemProperties.putAll(
//            mapOf(
//                "models" to "",
//                "modelTests" to "",
//                "modelDocs" to "",
//                "apis" to "",
//                "apiTests" to "",
//                "apiDocs" to ""
//            )
//        )
    }
    val cleanKotlinModels by creating(Delete::class) {
        group = "openapi"
        val modelsKt = project(":crowdproj-models-kt").projectDir
        fileTree(modelsKt).visit {
            if (file.name !in arrayOf(
                    "build.gradle.kts",
                    ".openapi-generator-ignore",
                    "src",
                    "main",
                    "kotlin",
                    "com",
                    "crowdproj",
                    "rest",
                    "Paths.kt"
                )) {
                delete(file)
            }
        }
    }

    create<GenerateTask>("generateJavaModels") {
        val genPackage = "${project.group}.rest"
        group = "openapi"
        val spec = "$rootDir/spec/crowdproj-spec.yaml"
        val dest = "$rootDir/crowdproj-models-jv"
        inputs.files(spec)
        outputs.files(fileTree(dest))
        generatorName.set("spring")
        inputSpec.set(spec)
        outputDir.set(dest)
        modelPackage.set("$genPackage.models")
        apiPackage.set("$genPackage.apis")
        packageName.set(genPackage)
        invokerPackage.set("$genPackage.infrastructure")
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
        configOptions.putAll(
            mutableMapOf(
                "swaggerAnnotations" to "true"
            )
        )
    }


    create<GenerateTask>("generateDartModels") {
        group = "openapi"
        val specFile = "$rootDir/spec/crowdproj-spec.yaml"
        val destDir = "$rootDir/crowdproj-front-private/crowdproj_models"
        inputs.files(specFile)
        outputs.files(fileTree(destDir), file("$destDir/pubspec.yaml"))
        generatorName.set("dart-dio")
        inputSpec.set(specFile)
        outputDir.set(destDir)
        packageName.set(project.group.toString())
//        modelPackage.set("${project.group}.models")
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
//        apiPackage.set("${project.group}.api")
//        invokerPackage.set("${project.group}.invoker")
        additionalProperties.set(
            mapOf(
                "pubName" to "crowdproj_models",
                "pubDescription" to "Crowdproj API generated REST-interface",
                "pubVersion" to project.version.toString()
            )
        )
    }

    val cleanDartModels by creating(Delete::class) {
        group = "openapi"
        val modelsDart = "${project(":crowdproj-front-private").projectDir}/crowdproj_models"
        fileTree(modelsDart).visit {
            if (!file.name.endsWith(".kts")) {
                delete(file)
            }
        }
    }

    create<Delete>("clean", Delete::class) {
        group = BasePlugin.BUILD_GROUP
        dependsOn(cleanDartModels)
        dependsOn(cleanKotlinModels)
    }
}
