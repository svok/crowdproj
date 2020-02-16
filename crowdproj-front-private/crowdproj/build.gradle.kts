plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    flutterPubUpgrade.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))

    create("build") {
        dependsOn(flutterBuildLinux)
        dependsOn(flutterBuildWeb)
    }

    create<Delete>("clean") {
        delete(buildDir)
    }
}

