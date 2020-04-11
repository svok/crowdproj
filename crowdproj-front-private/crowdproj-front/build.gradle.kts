plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    flutterPubUpgrade.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))

    val conf = project.configurations.create("webDistConfig")
    val setWebArtifact by creating {
        dependsOn(flutterBuildWeb)
        artifacts.add(conf.name, fileTree("$buildDir/web").dir)
    }

    create("build") {
        group = "build"
//        dependsOn(flutterBuildLinux)
        dependsOn(setWebArtifact)
    }

    create<Delete>("clean") {
        group = "build"
        delete(buildDir)
    }
}

