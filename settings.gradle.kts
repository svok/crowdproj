rootProject.name = "crowdproj"

// common
include(":crowdproj-common")
include(":crowdproj-common:crowdproj-common-kt")
include(":crowdproj-common:crowdproj-common-dt")

// teams backend
include(":crowdproj-teams")
include(":crowdproj-teams:generated-models-kt")
include(":crowdproj-teams:generated-models-dt")
include(":crowdproj-teams:back-main")
include(":crowdproj-teams:back-kotless-app")
include(":crowdproj-teams:front-teams-models")
include(":crowdproj-teams:front-teams-rest")
include(":crowdproj-teams:front-teams-stub")
include(":crowdproj-teams:front-teams")

// crowdptoj personal front application
include(":crowdproj-front-app")

// crowdptoj public web site
include(":crowdproj-front-web")

pluginManagement {

    val kotlinVersion: String by settings
    val openapiGeneratorVersion: String by settings
    val versionsPluginVersion: String by settings
    val kotlessVersion: String by settings
    val orchidVersion: String by settings
    val terraformPluginVersion: String by settings

    plugins {
        kotlin("jvm") version kotlinVersion apply false
        kotlin("multiplatform") version kotlinVersion apply false
        id("com.github.ben-manes.versions") version versionsPluginVersion apply false
        id("org.openapi.generator") version openapiGeneratorVersion apply false
        id("io.kotless") version kotlessVersion apply false

        id("com.eden.orchidPlugin") version orchidVersion

        id("org.ysb33r.terraform.base") version terraformPluginVersion apply false
        id("org.ysb33r.terraform") version terraformPluginVersion apply false
        id("org.ysb33r.terraform.rc") version terraformPluginVersion apply false
        id("org.ysb33r.terraform.wrapper") version terraformPluginVersion apply false
        id("org.ysb33r.terraform.remotestate.s3") version terraformPluginVersion apply false

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
include("crowdproj-back-main")
