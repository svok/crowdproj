group = rootProject.group
version = rootProject.version

plugins {
    kotlin("jvm")
}

dependencies {
    val kotlinVersion: String by project
    val coroutinesVersion: String by project
    val jacksonVersion: String by project
    val awsCoreVersion: String by project
    val awsLog4jVersion: String by project
    val awsEventsVersion: String by project
    val awsDynamoVersion: String by project

    implementation(project(":crowdproj-common:crowdproj-common-kt"))
    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-teams:generated-models-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")
}

