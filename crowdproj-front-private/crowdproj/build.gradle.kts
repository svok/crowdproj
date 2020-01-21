plugins {
}

group = rootProject.group
version = rootProject.version

tasks {

    val flutterCommand = "/home/sokatov/flutter/bin/flutter"

    val flutterInstall by creating(Exec::class) {

    }

    val buildFlutterLinux by creating(Exec::class) {
        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
        group = "build"
        executable = flutterCommand
        args = listOf(
            "build",
            "linux"
        )
    }

    val buildFlutterWeb by creating(Exec::class) {
        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
        group = "build"
        executable = flutterCommand
        args = listOf(
            "build",
            "web"
        )
    }

    val buildFlutterAndroid by creating(Exec::class) {
        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
        group = "build"
        executable = flutterCommand
        args = listOf(
            "build",
            "apk"
        )
    }

    val buildFlutterIos by creating(Exec::class) {
        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
        group = "build"
        executable = flutterCommand
        args = listOf(
            "build",
            "ios"
        )
    }

    val runFlutterLinux by creating(Exec::class) {
        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
        group = "run"
        executable = flutterCommand
        args = listOf(
            "run",
            "-d",
            "linux"
        )
    }

    val runFlutterWeb by creating(Exec::class) {
        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
        group = "run"
        executable = flutterCommand
        args = listOf(
            "run",
            "-d",
            "web"
        )
    }

//    val runFlutterAndroid by creating(Exec::class) {
//        dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
//        group = "run"
//        executable = flutterCommand
//        args = listOf(
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
//        args = listOf(
//            "run",
//            "-d",
//            "ios"
//        )
//    }

    create("build") {
        dependsOn(buildFlutterWeb)
        dependsOn(buildFlutterLinux)
    }
}

