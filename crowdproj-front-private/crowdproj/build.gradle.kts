plugins {
}
group = rootProject.group
version = rootProject.version

flutter {

}

tasks {

//    val runFlutterLinux by creating(Exec::class) {
//        dependsOn(generateModles)
//        group = "run"
//        executable = flutterBinPath
//        setArgs(listOf(
//            "run",
//            "-d",
//            "linux"
//        ))
//    }
//
//    val runFlutterWeb by creating(Exec::class) {
//        dependsOn(generateModles)
//        group = "run"
//        executable = flutterBinPath
//        setArgs(listOf(
//            "run",
//            "-d",
//            "web"
//        ))
//    }

//    val runFlutterAndroid by creating(Exec::class) {
//        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
//        group = "run"
//        executable = flutterCommand
//        setArgs(listOf(
//            "run",
//            "-d",
//            "apk"
//        )
//    }
//
//    val runFlutterIos by creating(Exec::class) {
//        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
//        group = "run"
//        executable = flutterCommand
//        setArgs(listOf(
//            "run",
//            "-d",
//            "ios"
//        )
//    }

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

