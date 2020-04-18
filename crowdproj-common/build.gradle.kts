import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("org.openapi.generator")
}

group = rootProject.group
version = rootProject.version

tasks {

    val build by creating {
        dependsOn(project(":crowdproj-common:crowdproj-common-dt").getTasksByName("build", false))
        dependsOn(project(":crowdproj-common:crowdproj-common-kt").getTasksByName("build", false))
    }
}
