plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {
    flutterPubUpgrade {
        inputs.dir(project(":crowdproj-teams:generated-models-kt").projectDir)
        inputs.dir(project(":crowdproj-teams:generated-models-dt").projectDir)
        dependsOn(project(":crowdproj-teams:front-teams-rest").getTasksByName("build", false))
        dependsOn(project(":crowdproj-teams:generated-models-dt").getTasksByName("build", false))
    }

    create("build") {
        group = "build"
        dependsOn(flutterPubUpgrade)
    }

}

