rootProject.name = "crowdproj"
include("crowdproj-backend")
include("crowdproj-models-kt")

pluginManagement {

    val kotlinVersion: String by settings
    val openapiGeneratorVersion: String by settings
    val versionsPluginVersion: String by settings

    plugins {
        kotlin("jvm") version kotlinVersion apply false
        kotlin("multiplatform") version kotlinVersion apply false
        id("com.github.ben-manes.versions") version versionsPluginVersion apply false
        id("org.openapi.generator") version openapiGeneratorVersion apply false

    }
}
