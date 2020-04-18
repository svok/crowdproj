plugins {
}
group = rootProject.group
version = rootProject.version

flutter {
}

tasks {

    val generateSources by creating
    flutterPubUpgrade.get().dependsOn(generateSources)
    val prepareDependencies by creating {
        dependsOn(flutterPubUpgrade)
    }

    create("build") {
        group = "build"
        dependsOn(prepareDependencies)
    }

}

