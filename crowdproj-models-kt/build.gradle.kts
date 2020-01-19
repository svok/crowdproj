plugins {
    kotlin("jvm")
}

group = rootProject.group
version = rootProject.version

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
}

tasks {
    compileKotlin.get().dependsOn(rootProject.getTasksByName("generateKotlinModels", false))
}

