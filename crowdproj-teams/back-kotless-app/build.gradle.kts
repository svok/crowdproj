import io.kotless.plugin.gradle.dsl.KotlessConfig
import io.kotless.plugin.gradle.dsl.kotless
import io.kotless.plugin.gradle.dsl.Webapp.Route53
import org.jetbrains.kotlin.gradle.dsl.KotlinJvmCompile

plugins {
    kotlin("jvm")
    id("io.kotless") apply true
}

group = rootProject.group
version = rootProject.version

repositories {
    mavenLocal()
    jcenter()
    mavenCentral()
}

application {
    applicationName = parent!!.name
}

dependencies {
    val kotlessVersion: String by project
    val ktorVersion: String by project
    val awsDynamoVersion: String by project
    val commonsValidatorVersion: String by project

    implementation(project(":crowdproj-teams:generated-models-kt"))
    implementation(project(":crowdproj-teams:back-main"))
    implementation(project(":crowdproj-common:crowdproj-common-kt"))

    implementation("io.kotless", "ktor-lang", kotlessVersion)
    implementation("io.kotless", "ktor-lang-local", kotlessVersion)
    implementation("commons-validator", "commons-validator", commonsValidatorVersion)
    implementation("com.amazonaws", "aws-java-sdk-dynamodb", awsDynamoVersion)
//    implementation("software.amazon.awssdk:dynamodb:2.11.9")

    implementation("io.ktor:ktor-locations:$ktorVersion")
    implementation("io.ktor:ktor-gson:$ktorVersion")
    implementation("io.ktor:ktor-client-apache:$ktorVersion")


//    implementation("io.ktor", "ktor-html-builder", ktorVersion)
}

kotless {
    val apiVersion: String by project
    val apiDomain: String by project
    val awsBucket: String by project
    val awsBucketState: String by project
    val awsProfile: String by project
    val awsRegions: String by project

    val serviceAlias = "${apiVersion}-teams"

    config {
        bucket = "$awsBucket.$apiVersion-backend"
        prefix = serviceAlias

//        dsl {
//            workDirectory = file("src/main/static")
//        }

        terraform {
            backend {
                bucket = awsBucketState
                key = "states-$apiVersion/state-teams.tfstate"
            }
            provider {
//                version = "2.60.0"
            }
            profile = awsProfile
            region = awsRegions.split(Regex(",\\s*")).first()
//            version = "0.12.24"
        }
        optimization {
            mergeLambda = io.kotless.KotlessConfig.Optimization.MergeLambda.All
            autowarm = KotlessConfig.Optimization.Autowarm(enable = false, minutes = 0)
        }
    }

    webapp {
        //Optional parameter, by default technical name will be generated
        route53 = Route53(serviceAlias, apiDomain, apiDomain)
        deployment {
            name = parent!!.name
            version = "1"
        }

        lambda {
            kotless {
            }
        }
    }

    extensions {
        local {
            useAWSEmulation = true
            port = 8081
        }

        terraform {
            allowDestroy = true
            files {
//                add(file("src/main/tf/bucket-init.tf"))
                add(file("src/main/tf/dynamodb.tf"))
                add(file("src/main/tf/cors-teams-index.tf"))
                add(file("src/main/tf/cors-teams-create.tf"))
                add(file("src/main/tf/cors-teams-update.tf"))
                add(file("src/main/tf/cors-teams-get.tf"))
            }
        }
    }
}

tasks {

    val kotlinJvmTarget: String by project

    withType<KotlinJvmCompile> {
        kotlinOptions {
            jvmTarget = kotlinJvmTarget
            languageVersion = "1.3"
            apiVersion = "1.3"
        }
    }

    withType<io.kotless.plugin.gradle.tasks.gen.KotlessGenerateTask> {
        doLast {
            println("COOOPY")
            copy {
                from("src/main/tf/dynamodb-access.tf")
                into(myGenDirectory)
                println("COOOPY IN $myGenDirectory")
            }
        }
    }

    clean {
        delete("$projectDir/out")
    }
}
