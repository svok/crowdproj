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
    val kotestVersion: String by project
    val slf4jVersion: String by project

    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-teams:back-storage-common"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")

    implementation("org.apache.logging.log4j:log4j-api:$slf4jVersion")
    implementation("org.apache.logging.log4j:log4j-core:$slf4jVersion")
    implementation("org.apache.logging.log4j:log4j-slf4j18-impl:$slf4jVersion")
    runtimeOnly("com.amazonaws:aws-lambda-java-log4j2:1.2.0")

    testImplementation("io.kotest:kotest-runner-junit5:$kotestVersion")
}

tasks {
    test {
        useJUnitPlatform()
    }
}
