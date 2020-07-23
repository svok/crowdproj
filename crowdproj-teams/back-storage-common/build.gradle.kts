group = rootProject.group
version = rootProject.version

plugins {
    kotlin("jvm")
}

repositories {
    maven { setUrl("http://repo.maven.apache.org/maven2") }
}

tasks {
}


dependencies {
    val kotlinVersion: String by project
    val coroutinesVersion: String by project

    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")
}

