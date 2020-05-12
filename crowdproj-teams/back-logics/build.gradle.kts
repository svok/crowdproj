plugins {
    kotlin("jvm")
}

dependencies {
    val konveyorVersion: String by project

    implementation(project(":crowdproj-common:crowdproj-common-kt"))
    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-teams:back-storage-common"))

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
