group = rootProject.group
version = rootProject.version

plugins {
    kotlin("jvm")
}

dependencies {
    val kotlinVersion: String by project
    val coroutinesVersion: String by project
    val kotestVersion: String by project

    implementation(project(":crowdproj-common:crowdproj-common-kt"))
    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-teams:generated-models-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")

    testImplementation("io.kotest:kotest-runner-junit5:$kotestVersion")
}

tasks {
    test {
        useJUnitPlatform()
    }

//    compileKotlin {
//        dependsOn(project(":crowdproj-teams:generated-models-dt").getTasksByName("build", false))
//    }
}
