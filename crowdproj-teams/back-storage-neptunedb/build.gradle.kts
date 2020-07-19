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
//    val awsDynamoVersion: String by project
    val gremlinDriverVersion: String by project
    val kotestVersion: String by project

    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-teams:back-storage-common"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")

//    implementation("com.amazonaws:aws-java-sdk-dynamodb:$awsDynamoVersion")
    implementation("org.apache.tinkerpop:gremlin-driver:$gremlinDriverVersion")

    testImplementation("io.kotest:kotest-runner-junit5:$kotestVersion")
}

tasks {
    test {
        useJUnitPlatform()
    }
}
