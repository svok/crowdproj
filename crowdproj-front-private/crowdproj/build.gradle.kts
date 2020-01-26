plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
//    val flutterBinPath: String by project
//    this.flutterCommand = flutterCommand
}

tasks {

    flutterBuildLinux.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterBuildWeb.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterBuildAndroid.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterBuildWindows.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterBuildIos.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterBuildMacos.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))

    flutterRunLinux.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterRunWeb.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterRunAndroid.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterRunWindows.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterBuildMacos.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))
    flutterRunIos.get()
        .dependsOn(project(":crowdproj-front-private:crowdproj_models").getTasksByName("build", false))


    create("build") {
        dependsOn(flutterBuildLinux)
        dependsOn(flutterBuildWeb)
    }

    create<Delete>("clean") {
        delete(buildDir)
    }
}

