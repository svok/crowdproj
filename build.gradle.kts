import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("com.github.ben-manes.versions")
    id("org.openapi.generator")
    id("org.ysb33r.terraform.wrapper")
}

group = "com.crowdproj"
version = "0.0.1"

val awsBucket: String by project
val apiVersion: String by project
val apiDomain: String by project

rootProject.apply {
    extra["awsBucketPublic"] = "$awsBucket.$apiVersion-public"
    extra["awsBucketPrivate"] = "$awsBucket.$apiVersion"
    extra["domainPublic"] = "$apiVersion.$apiDomain"
}

allprojects {
    repositories {
        mavenCentral()
        jcenter()
    }
}

tasks {

    val build by creating {
        group = "build"
        dependsOn(project(":crowdproj-common").getTasksByName("build", false))
        dependsOn(project(":crowdproj-teams").getTasksByName("build", false))
        dependsOn(project(":crowdproj-front-app").getTasksByName("build", false))
    }

    val clean by creating(Delete::class) {
        group = "build"
        delete("$projectDir/res")
    }

}
