plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    create("build") {
        dependsOn(flutterPubUpgrade)
    }

    create<Delete>("clean") {
        group = "build"
        delete(buildDir)
    }
}

