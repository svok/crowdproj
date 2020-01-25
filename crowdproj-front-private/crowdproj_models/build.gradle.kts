plugins {
}
group = rootProject.group
version = rootProject.version

flutter {

}

tasks {

    val generateModles by creating {
        dependsOn(rootProject.getTasksByName("generateDartModels", false))
    }

    create("build") {
        dependsOn(flutterBuildRunner)
    }

}

