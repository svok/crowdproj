plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
//    val flutterBinPath: String by project
//    println("FLUTTER COMMAND: $flutterBinPath")
//    this.flutterCommand = flutterBinPath
}

tasks {

    val generateModels by creating {
        dependsOn(
            rootProject.getTasksByName(
                "generateDartModels",
                false
            )
        )
    }

    flutterPubUpgrade {
        dependsOn(generateModels)
    }

    create("build") {
        dependsOn(flutterBuildRunner)
    }

}

