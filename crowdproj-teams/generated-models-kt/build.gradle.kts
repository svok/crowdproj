plugins {
    kotlin("jvm")
}

group = rootProject.group
version = rootProject.version

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
}

sourceSets {
    main {
        java {
            srcDir("src")
//            exclude("**/apis/**")
        }
    }
}

tasks {
    val specFile = "${parent!!.projectDir}/spec.yaml"

    val modelsKt = project(":crowdproj-teams:generated-models-kt")

    val generateKotlinModels by creating(org.openapitools.generator.gradle.plugin.tasks.GenerateTask::class) {
        group = "openapi"
        val destDir = modelsKt.projectDir
        val genPackage = "${project.group}.rest.teams"
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
        systemProperties.putAll(
            mapOf(
                "models" to "",
                "modelTests" to ""
//                "modelDocs" to "",
//                "apis" to "",
//                "apiTests" to "",
//                "apiDocs" to ""
            )
        )
    }
    clean {
//        group = "openapi"
        fileTree(modelsKt.projectDir).visit {
            if (file.name !in arrayOf(
                    "build.gradle.kts",
                    ".openapi-generator-ignore",
                    "src",
                    "main",
                    "kotlin",
                    "com",
                    "crowdproj",
                    "rest"
//                    "Paths.kt"
                )) {
                delete(file)
            }
        }
    }

    compileKotlin {
        dependsOn(generateKotlinModels)
    }
}

