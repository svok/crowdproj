import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    id("org.openapi.generator")
}

group = rootProject.group
version = rootProject.version

tasks {

    create("build") {
        group = "build"
//        dependsOn(generateDartModels)
//        dependsOn(generateKotlinModels)
        dependsOn(project(":crowdproj-teams:front-teams").getTasksByName("build", false))
        dependsOn(project(":crowdproj-teams:crowdproj-teams-aws").getTasksByName("build", false))
    }

    create<Delete>("clean", Delete::class) {
        group = BasePlugin.BUILD_GROUP
//        dependsOn(cleanDartModels)
//        dependsOn(cleanKotlinModels)
    }

}
