plugins {
}

group = rootProject.group
version = rootProject.version

tasks {

    val flutterCommand = "/home/sokatov/flutter/bin/flutter"

    val flutterInstall by creating(Exec::class) {

    }

    val generateModles by creating {
        dependsOn(rootProject.getTasksByName("generateDartModels", false))
    }

    val buildFlutterLinux by creating(Exec::class) {
        dependsOn(generateModles)
        group = "build"
        inputs.files(
            fileTree("$projectDir/linux"),
            fileTree("$projectDir/assets"),
            fileTree("$projectDir/fonts"),
            fileTree("$projectDir/lib")
        )
        outputs.files(
            fileTree("$buildDir/linux/release")
        )
        executable = flutterCommand
        args = listOf(
            "build",
            "linux"
        )
    }

    val buildFlutterWeb by creating(Exec::class) {
        dependsOn(generateModles)
        group = "build"
        inputs.files(
            fileTree("$projectDir/web"),
            fileTree("$projectDir/assets"),
            fileTree("$projectDir/fonts"),
            fileTree("$projectDir/lib")
        )
        outputs.files(
            fileTree("$buildDir/web")
        )
        executable = flutterCommand
        args = listOf(
            "build",
            "web"
        )
    }

    val buildFlutterAndroid by creating(Exec::class) {
        dependsOn(generateModles)
        group = "build"
        inputs.files("android/app", "assets", "fonts", "lib")
        inputs.files(
            fileTree("$projectDir/android/app"),
            file("$projectDir/android/build.gradle"),
            file("$projectDir/android/gradle.properties"),
            fileTree("$projectDir/android/gradle"),
            fileTree("$projectDir/assets"),
            fileTree("$projectDir/fonts"),
            fileTree("$projectDir/lib")
        )
        outputs.files(
            fileTree("$buildDir/app/outputs/bundle")
        )

        executable = flutterCommand
        args = listOf(
            "build",
            "appbundle", "--target-platform", "android-arm,android-arm64,android-x64"
        )
    }

    val buildFlutterIos by creating(Exec::class) {
        dependsOn(generateModles)
        group = "build"
        executable = flutterCommand
        args = listOf(
            "build",
            "ios"
        )
    }

    val runFlutterLinux by creating(Exec::class) {
        dependsOn(generateModles)
        group = "run"
        executable = flutterCommand
        args = listOf(
            "run",
            "-d",
            "linux"
        )
    }

    val runFlutterWeb by creating(Exec::class) {
        dependsOn(generateModles)
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

    create<Delete>("clean") {
        delete(buildDir)
    }
}

