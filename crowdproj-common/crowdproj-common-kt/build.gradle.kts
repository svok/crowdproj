plugins {
    kotlin("jvm")
}

dependencies {
    val konveyorVersion: String by project
    implementation(kotlin("stdlib-jdk8"))
    implementation("codes.spectrum:konveyor:$konveyorVersion")
}

tasks {

    val kotlinJvmTarget: String by project

    compileKotlin {
        kotlinOptions.jvmTarget = kotlinJvmTarget
    }
    compileTestKotlin {
        kotlinOptions.jvmTarget = kotlinJvmTarget
    }

    clean {
        delete("$projectDir/out")
    }
}
