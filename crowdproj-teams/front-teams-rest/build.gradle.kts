plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    flutterPubUpgrade.get().dependsOn(project(":crowdproj-teams:generated-models-dt").getTasksByName("build", false))

    create("build") {
        group = "build"
        dependsOn(flutterPubUpgrade)
    }

}

