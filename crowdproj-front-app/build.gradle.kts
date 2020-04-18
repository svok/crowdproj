plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    flutterPubUpgrade {
        dependsOn(project(":crowdproj-teams:front-teams").getTasksByName("build", false))
        dependsOn(project(":crowdproj-common:crowdproj-common-dt").getTasksByName("build", false))
    }

//    val conf = project.configurations.create("webDistConfig")
//    val setWebArtifact by creating {
//        dependsOn(flutterBuildWeb)
//        artifacts.add(conf.name, fileTree("$buildDir/web").dir)
//    }

    create("build") {
        group = "build"
        dependsOn(flutterBuildWeb)
//        dependsOn(setWebArtifact)
    }

    create<Delete>("clean") {
        group = "build"
        delete(buildDir)
    }
}

