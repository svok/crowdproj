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
    val jacksonVersion: String by project
    val awsCoreVersion: String by project
    val awsLog4jVersion: String by project
    val awsEventsVersion: String by project
    val awsDynamoVersion: String by project

    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")

//    implementation("com.amazonaws:aws-lambda-java-core:$awsCoreVersion")
//    implementation("com.amazonaws:aws-lambda-java-log4j2:$awsLog4jVersion")
//    implementation("com.amazonaws:aws-lambda-java-events:$awsEventsVersion")
    implementation("com.amazonaws:aws-java-sdk-dynamodb:$awsDynamoVersion")
}

