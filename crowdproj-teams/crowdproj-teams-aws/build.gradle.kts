group = rootProject.group
version = rootProject.version

plugins {
    kotlin("jvm")
    id("com.github.johnrengelman.shadow")
    id("org.ysb33r.terraform")
    id("org.ysb33r.terraform.remotestate.s3")
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

dependencies {
    val kotlinVersion: String by project
    val coroutinesVersion: String by project
    val jacksonVersion: String by project
    val awsCoreVersion: String by project
    val awsLog4jVersion: String by project
    val awsEventsVersion: String by project
    val awsDynamoVersion: String by project
    val awsSsmVersion: String by project

    implementation(project(":crowdproj-teams:generated-models-kt"))
    implementation(project(":crowdproj-teams:back-common"))
    implementation(project(":crowdproj-teams:back-logics"))
    implementation(project(":crowdproj-teams:back-storage-common"))
    implementation(project(":crowdproj-teams:back-storage-dynamodb"))
    implementation(project(":crowdproj-teams:back-transport-rest"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")

    implementation("com.amazonaws:aws-lambda-java-core:$awsCoreVersion")
    implementation("com.amazonaws:aws-lambda-java-log4j2:$awsLog4jVersion")
    implementation("com.amazonaws:aws-lambda-java-events:$awsEventsVersion")
    implementation("com.amazonaws:aws-java-sdk-ssm:$awsSsmVersion")
    implementation("com.amazonaws:aws-java-sdk-dynamodb:$awsDynamoVersion")

    implementation("com.fasterxml.jackson.core:jackson-core:$jacksonVersion")
    implementation("com.fasterxml.jackson.core:jackson-databind:$jacksonVersion")
    implementation("com.fasterxml.jackson.core:jackson-annotations:$jacksonVersion")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin:$jacksonVersion")
}

val awsRegions: String by project
val apiVersion: String by project
val apiDomain: String by project
val awsBucket: String by project
val awsBucketState: String by project

val serviceAlias = "$apiVersion-teams"
val bucketBackend = "$awsBucket.$apiVersion"

val paramsPrefix = "$awsBucket.$serviceAlias"
val paramCorsOrigins = "$paramsPrefix.cors-origins"
val paramCorsHeaders = "$paramsPrefix.cors-headers"
val paramCorsMethods = "$paramsPrefix.cors-methods"

terraform {
    this.executable(mapOf(
        "version" to "0.12.24"
    ))
    variables {
//        `var`("sourcePath", )
        `var`("region", awsRegions)
        `var`("domainZone", apiDomain)
        `var`("domain", "$serviceAlias.$apiDomain")
        `var`("bucketJarName", "$awsBucket.$serviceAlias")
        `var`("bucketBackend", bucketBackend)
        `var`("handlerJar", tasks.shadowJar.get().archiveFile.get().asFile.absoluteFile)
        `var`("parametersPrefix", paramsPrefix)
        `var`("parameterCorsOrigins", paramCorsOrigins)
        `var`("parameterCorsHeaders", paramCorsHeaders)
        `var`("parameterCorsMethods", paramCorsMethods)
        map(mapOf<String, String>(
            "teams-create" to "com.crowdproj.aws.handlers.TeamsCreateHandler::handleRequest",
            "teams-update" to "com.crowdproj.aws.handlers.TeamsUpdateHandler::handleRequest",
            "teams-index" to "com.crowdproj.aws.handlers.TeamsIndexHandler::handleRequest",
            "teams-get" to "com.crowdproj.aws.handlers.TeamsGetHandler::handleRequest"
        ), "handlers")
        list("corsOrigins",
//            "https://crowdproj.com",
//            "https://private.crowdproj.com",
            "https://$apiVersion-private.crowdproj.com"
        )
        list("corsHeaders",
            "*",
            "Content-Type",
            "X-Amz-Date",
            "Authorization",
            "X-Api-Key",
            "X-Amz-Security-Token",
            "X-Requested-With"
        )
        list("corsMethods",
            "OPTIONS", "POST"
        )
//        `var`("stateTable", "arn:aws:dynamodb:us-east-1:709565996550:table/com.crowdproj.states")
//        `var`("health_check_alarm_sns_topics", "crowdproj-public-website-alarm")
    }
    remote {
        setPrefix("states-$apiVersion/state-teams")
        s3 {
            setRegion(awsRegions)
            setBucket(awsBucketState)
        }
    }
}

val generatedCode = "$buildDir/generated/main/kotlin"

tasks {
    tfApply {
        dependsOn(tfInit)
        dependsOn(shadowJar)
        inputs.file(shadowJar.get().archiveFile)
        inputs.file("build.gradle.kts")
    }

    val prepareConstants by creating {
        val fileCode = """
            package ${project.group}.aws
            
            // Autogenerated constants from gradle.build.kts
            object CrowdprojConstants {
                const val parameterCorsOrigins = "$paramCorsOrigins"
                const val parameterCorsHeaders = "$paramCorsHeaders"
                const val parameterCorsMethods = "$paramCorsMethods"
            }
        """.trimIndent()
        val dir = "$generatedCode/${project.group.toString().replace(".", "/")}/aws"
        file(dir).mkdirs()
        file("$dir/CrowdprojConstants.kt")
            .writeText(fileCode)
    }
    compileKotlin {
        dependsOn(prepareConstants)
        sourceSets {
            getByName("main") {
                java.srcDir(generatedCode)
            }
        }
    }

    val deployAws by creating {
        group = "deploy"
        dependsOn(tfApply)
    }

    val deploy by creating {
        group = "deploy"
        dependsOn(deployAws)
    }
}

