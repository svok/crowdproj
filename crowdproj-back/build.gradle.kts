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
    jcenter()
    mavenCentral()
}

dependencies {
    val kotlessVersion: String by project
    val ktorVersion: String by project
    val awsVersion: String by project
    val commonsValidatorVersion: String by project

    implementation(project(":crowdproj-front-private:crowdproj", "webDistConfig"))
    implementation("io.kotless", "ktor-lang", kotlessVersion)
    implementation("io.kotless", "ktor-lang-local", kotlessVersion)
    implementation("commons-validator", "commons-validator", commonsValidatorVersion)
    implementation("com.amazonaws", "aws-java-sdk-dynamodb", awsVersion)

    implementation("io.ktor", "ktor-html-builder", ktorVersion)
}

kotless {
    val apiVersion: String by project
    val apiDomain: String by project
    val awsBucket: String by project
    val awsProfile: String by project
    val awsRegions: String by project

    config {
        bucket = awsBucket
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
            name = "name"
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
            }
        }
    }
}

tasks {
    val copyStatic = task<Sync>("copyWebDist") {
        dependsOn(project(":crowdproj-front-private:crowdproj").getTasksByName("setWebArtifact", false))
        project(":crowdproj-front-private:crowdproj").configurations.forEach {
            println("CONFIGf: ${it.name}")
        }
        from(project(":crowdproj-front-private:crowdproj").configurations.getByName("webDistConfig").artifacts.files)
        into("$buildDir/web-static")
    }

    withType<KotlinJvmCompile> {
        dependsOn(copyStatic)
        kotlinOptions {
            jvmTarget = "1.8"
            languageVersion = "1.3"
            apiVersion = "1.3"
        }
    }

//    getByName("generate").dependsOn(copyStatic)

}
