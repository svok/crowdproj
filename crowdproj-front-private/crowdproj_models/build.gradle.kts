plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
    val flutterBinPath: String by project
    this.flutterCommand = flutterCommand
}

tasks {

    val generateModles by creating {
        dependsOn(rootProject.getTasksByName("generateDartModels", false))
    }

    create("build") {
        dependsOn(flutterBuildRunner)
    }

}

