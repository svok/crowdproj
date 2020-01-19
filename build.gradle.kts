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
    create<org.openapitools.generator.gradle.plugin.tasks.GenerateTask>("generateKotlinModels") {
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

    create<Delete>("clean", Delete::class) {
        group = BasePlugin.BUILD_GROUP
//        val modelsJs = project(":models-js").projectDir
//        fileTree(modelsJs).visit {
//            if (!file.name.endsWith(".kts")) {
//                delete(file)
//            }
//        }
//        delete("$modelsJs/.gradle")

//        val backendApi = "${project(":backend-api").projectDir}/src/main/kotlin/ru/iteco/dfu/nma/backend/controllers"
//        fileTree(backendApi).visit {
//            delete(file)
//        }

        val modelsKt = project(":crowdproj-models-kt").projectDir
        fileTree(modelsKt).visit {
            if (!file.name.endsWith(".kts")) {
                delete(file)
            }
        }
    }
}
