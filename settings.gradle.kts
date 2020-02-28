rootProject.name = "crowdproj"
include(":crowdproj-models-kt")
include(":crowdproj-front-private:crowdproj_models")
include(":crowdproj-front-private:crowdproj")
include(":crowdproj-back")

pluginManagement {

    val kotlinVersion: String by settings
    val openapiGeneratorVersion: String by settings
    val versionsPluginVersion: String by settings
    val kotlessVersion: String by settings

    plugins {
        kotlin("jvm") version kotlinVersion apply false
        kotlin("multiplatform") version kotlinVersion apply false
        id("com.github.ben-manes.versions") version versionsPluginVersion apply false
        id("org.openapi.generator") version openapiGeneratorVersion apply false
        id("io.kotless") version kotlessVersion apply false
    }

    repositories {
        mavenLocal()
        jcenter()
        mavenCentral()
        gradlePluginPortal()
    }
}
