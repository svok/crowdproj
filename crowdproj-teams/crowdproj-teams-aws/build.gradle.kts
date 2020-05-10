group = rootProject.group
version = rootProject.version

plugins {
    kotlin("jvm")
    id("com.github.johnrengelman.shadow")
}

repositories {
    maven { setUrl("http://repo.maven.apache.org/maven2") }
}

// If requiring AWS JDK, uncomment the dependencyManagement to use the bill of materials
//   https://aws.amazon.com/blogs/developer/managing-dependencies-with-aws-sdk-for-java-bill-of-materials-module-bom/
//dependencyManagement {
//    imports {
//        mavenBom("com.amazonaws:aws-java-sdk-bom:1.11.206")
//    }
//}

tasks {
    val conf = project.configurations.create("serverlessArtifacts")
    val setArtifacts = create("setArtifacts") {
        dependsOn(shadowJar)
        artifacts.add(conf.name, shadowJar.get().archiveFile)
    }

    build.get().dependsOn(setArtifacts)
}


val kotlinVersion: String by project
val coroutinesVersion: String by project
val jacksonVersion: String by project
val awsCoreVersion: String by project
val awsLog4jVersion: String by project
val awsEventsVersion: String by project
val awsDynamoVersion: String by project

dependencies {
    implementation(project(":crowdproj-teams:generated-models-kt"))
    implementation(project(":crowdproj-teams:back-main"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")

    implementation("com.amazonaws:aws-lambda-java-core:$awsCoreVersion")
    implementation("com.amazonaws:aws-lambda-java-log4j2:$awsLog4jVersion")
    implementation("com.amazonaws:aws-lambda-java-events:$awsEventsVersion")
    implementation("com.amazonaws:aws-java-sdk-dynamodb:$awsDynamoVersion")

    implementation("com.fasterxml.jackson.core:jackson-core:$jacksonVersion")
    implementation("com.fasterxml.jackson.core:jackson-databind:$jacksonVersion")
    implementation("com.fasterxml.jackson.core:jackson-annotations:$jacksonVersion")
}
