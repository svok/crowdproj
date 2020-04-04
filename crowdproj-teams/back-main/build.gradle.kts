plugins {
    kotlin("jvm")
}

dependencies {
    val konveyorVersion: String by project

    implementation(project(":crowdproj-common"))

    implementation(kotlin("stdlib-jdk8"))
    implementation("codes.spectrum:konveyor:$konveyorVersion")
}

tasks {
    compileKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
    compileTestKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
}
