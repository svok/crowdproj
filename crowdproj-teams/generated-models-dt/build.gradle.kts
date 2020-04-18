plugins {
    id("org.openapi.generator")
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    val specFile = "${parent!!.projectDir}/spec.yaml"

    val generateDartModels by creating(org.openapitools.generator.gradle.plugin.tasks.GenerateTask::class) {
        group = "openapi"
        val destDir = project.projectDir
        val genPackage = "${project.group}.rest.teams"
        inputs.files(specFile)
        outputs.files(fileTree(destDir), file("$destDir/pubspec.yaml"))
        generatorName.set("dart-dio")
        inputSpec.set(specFile)
        outputDir.set(destDir.absolutePath)
        packageName.set(project.group.toString())
        generateModelDocumentation.set(true)
        generateModelTests.set(true)
        additionalProperties.set(
            mapOf(
                "pubName" to "generated_models_teams",
                "pubDescription" to "Crowdproj Teams API generated REST-interface",
                "pubVersion" to project.version.toString()
            )
        )
    }

    val cleanDartModels by creating(Delete::class) {
        group = "openapi"
        fileTree(project.projectDir).visit {
            if (file.name !in listOf(
                    "build.gradle.kts",
                    ".openapi-generator-ignore"
                )
            ) {
                delete(file)
            }
        }
    }

    flutterPubUpgrade.get().dependsOn(generateDartModels)

    val buildFlutter by creating {
        dependsOn(flutterBuildRunner)
    }

    create("build") {
        group = "build"
        dependsOn(buildFlutter)
    }

    create("clean") {
        group = "build"
        dependsOn(cleanDartModels)
    }

}

