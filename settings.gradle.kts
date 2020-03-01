rootProject.name = "crowdproj"
include(":crowdproj-models-kt")
include(":crowdproj-front-private:crowdproj_models")
include(":crowdproj-front-private:crowdproj")
include(":crowdproj-front-public")
include(":crowdproj-back")

pluginManagement {

    val kotlinVersion: String by settings
    val openapiGeneratorVersion: String by settings
    val versionsPluginVersion: String by settings
    val kotlessVersion: String by settings
    val orchidVersion: String by settings

    plugins {
        kotlin("jvm") version kotlinVersion apply false
        kotlin("multiplatform") version kotlinVersion apply false
        id("com.github.ben-manes.versions") version versionsPluginVersion apply false
        id("org.openapi.generator") version openapiGeneratorVersion apply false
        id("io.kotless") version kotlessVersion apply false

        id("com.eden.orchidPlugin") version orchidVersion
    }

    repositories {
        mavenLocal()
        jcenter()
        mavenCentral()
        gradlePluginPortal()
        maven(url = "https://kotlin.bintray.com/kotlinx")
        maven(url = "https://jitpack.io")
    }
}
