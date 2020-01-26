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

    val generateModles by creating {
        dependsOn(
            rootProject.getTasksByName(
                "generateDartModels",
                false
            )
        )
    }

    flutterPubUpgrade {
        dependsOn(generateModles)
    }

    create("build") {
        dependsOn(flutterBuildRunner)
    }

}

