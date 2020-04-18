import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("com.github.ben-manes.versions")
    id("org.openapi.generator")
}

group = "com.crowdproj"
version = "0.0.1"

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
}
