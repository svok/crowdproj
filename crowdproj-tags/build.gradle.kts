import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("org.openapi.generator")
}

group = rootProject.group
version = rootProject.version

tasks {

    val specFile = "${project.projectDir}/spec.yaml"

    val modelsKt = project(":crowdproj-tags:generated-models-kt")

    create<GenerateTask>("generateKotlinModels") {
        group = "openapi"
        val destDir = modelsKt.projectDir
        val genPackage = "${project.group}.rest.tags"
        inputs.files(specFile)
        outputs.files(fileTree(destDir))
        generatorName.set("kotlin-server")
        inputSpec.set(specFile)
        outputDir.set(destDir.absolutePath)
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
        fileTree(modelsKt.projectDir).visit {
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

    val modelsDt = project(":crowdproj-tags:generated-models-dt")

    create<GenerateTask>("generateDartModels") {
        group = "openapi"
        val destDir = modelsDt.projectDir
        val genPackage = "${project.group}.rest.tags"
        inputs.files(specFile)
        outputs.files(fileTree(destDir), file("$destDir/spec.yaml"))
        generatorName.set("dart-dio")
        inputSpec.set(specFile)
        outputDir.set(destDir.absolutePath)
        packageName.set(project.group.toString())
//        modelPackage.set("${project.group}.models")
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
//        apiPackage.set("${project.group}.api")
//        invokerPackage.set("${project.group}.invoker")
        additionalProperties.set(
            mapOf(
                "pubName" to "generated_models_tags",
                "pubDescription" to "Crowdproj Tags API generated REST-interface",
                "pubVersion" to project.version.toString()
            )
        )
    }

    val cleanDartModels by creating(Delete::class) {
        group = "openapi"
        fileTree(modelsDt.projectDir).visit {
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
