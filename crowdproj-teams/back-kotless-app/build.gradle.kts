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

dependencies {
    val kotlessVersion: String by project
    val ktorVersion: String by project
    val awsVersion: String by project
    val commonsValidatorVersion: String by project

    implementation(project(":crowdproj-teams:generated-models-kt"))
    implementation(project(":crowdproj-teams:back-main"))
    implementation(project(":crowdproj-common"))

    implementation("io.kotless", "ktor-lang", kotlessVersion)
    implementation("io.kotless", "ktor-lang-local", kotlessVersion)
    implementation("commons-validator", "commons-validator", commonsValidatorVersion)
    implementation("com.amazonaws", "aws-java-sdk-dynamodb", awsVersion)

//    implementation("io.ktor:ktor-server-netty:$ktorVersion")
//    implementation("io.ktor:ktor-metrics:$ktorVersion")
    implementation("io.ktor:ktor-locations:$ktorVersion")
    implementation("io.ktor:ktor-gson:$ktorVersion")
//    implementation("io.ktor:ktor-client-core:$ktorVersion")
    implementation("io.ktor:ktor-client-apache:$ktorVersion")


//    implementation("io.ktor", "ktor-html-builder", ktorVersion)
}

kotless {
    val apiVersion: String by project
    val apiDomain: String by project
    val awsBucket: String by project
    val awsProfile: String by project
    val awsRegions: String by project

    config {
        bucket = "$awsBucket.teams"
        prefix = apiVersion

//        dsl {
//            workDirectory = file("src/main/static")
//        }

        terraform {
            profile = awsProfile
            region = awsRegions.split(Regex(",\\s*")).first()
        }

    }

    webapp {
        //Optional parameter, by default technical name will be generated
        route53 = Route53(apiVersion, apiDomain, apiDomain)
        deployment {
            name = "crowdproj-front-private"
            version = "1"
        }
    }

    extensions {
        local {
            useAWSEmulation = true
            port = 8081
        }

        terraform {
            files {
                add(file("src/main/tf/extensions.tf"))
//                add(file("src/main/tf/ttf-files.ft"))
            }
        }
    }
}

tasks {

    val kc = withType<KotlinJvmCompile> {
        kotlinOptions {
            jvmTarget = "1.8"
            languageVersion = "1.3"
            apiVersion = "1.3"
        }
    }

}
