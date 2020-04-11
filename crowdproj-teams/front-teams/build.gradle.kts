plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    create("build") {
        group = "build"
        dependsOn(flutterPubUpgrade)
    }

}

