plugins {
    id("com.eden.orchidPlugin")
//    id("org.ysb33r.terraform.base")
    id("org.ysb33r.terraform")
    id("org.ysb33r.terraform.remotestate.s3")
//    id("org.ysb33r.terraform.rc")
//    id("org.ysb33r.terraform.wrapper")
}

repositories {
    jcenter()
    mavenCentral()
    maven(url = "https://kotlin.bintray.com/kotlinx")
    maven(url = "https://jitpack.io")
}

dependencies {
    val orchidVersion: String by project

    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidAll:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidPages:$orchidVersion")
//    implementation("io.github.javaeden.orchid:OrchidCore:$orchidVersion")
//    orchidImplementation("io.github.javaeden.orchid:OrchidCore:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidPosts:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidWiki:$orchidVersion")
////    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidNetlifyCMS:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidPluginDocs:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidSearch:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidWritersBlocks:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidSyntaxHighlighter:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidTaxonomies:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidFutureImperfect:$orchidVersion")

    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidEditorial:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidBsDoc:$orchidVersion")
}

val orchidDest = "$buildDir/docs"
val orchidContentDest = orchidDest

val awsRegions: String by project
val apiVersion: String by project
val apiDomain: String by project
val awsBucket: String by project
val awsBucketState: String by project

val serviceAlias = "$apiVersion-public"


orchid {
    theme = "BsDoc"
    version = "${project.version}"
//    baseUrl = "https://$serviceAlias.$apiDomain"                         // a baseUrl prepended to all generated links. Defaults to '/'
//    srcDir  = "path/to/new/source/directory"      // defaults to 'src/orchid/resources'
//    destDir = "path/to/new/destination/directory" // defaults to 'build/docs/orchid'
    runTask = "build"                             // specify a task to run with 'gradle orchidRun'
    destDir = orchidDest
    diagnose = true
}

terraform {
//    val awsBucketPublic: String by project(":crowdproj-common:crowdproj-common-aws").extra
    val awsBucketPublic: String by rootProject.extra
    val bucketPublic = awsBucketPublic
    variables {
        `var`("sourcePath", orchidContentDest)
        `var`("region", awsRegions)
        `var`("bucketPublic", bucketPublic)
        map(mapOf<String, String>(
            "txt" to "text/plain",
            "html" to "text/html",
            "xml" to "text/xml",
            "yml" to  "application/yaml",
            "yaml" to "application/yaml",
            "css" to "text/css",
            "jpg" to "image/jpeg",
            "jpeg" to "image/jpeg",
            "ttf" to "font/ttf",
            "js" to "application/javascript",
            "map" to "application/javascript",
            "json" to "application/json",
            "ico" to "image/vnd.microsoft.icon"
        ), "mime_types")
    }
    remote {
        setPrefix("states-$apiVersion/state-public")
        s3 {
            setRegion(awsRegions)
            setBucket(awsBucketState)
        }
    }
}

tasks {

    orchidBuild {
        inputs.dir("src")
        outputs.dir(orchidDest)
        doFirst {
            delete(orchidDest)
        }
    }

    tfApply {
        dependsOn(":crowdproj-common:crowdproj-common-aws:tfApply")
        dependsOn(tfInit)
        dependsOn(orchidBuild)
        inputs.dir(orchidDest)
        inputs.dir("$projectDir/src/tf/main")
        inputs.file("build.gradle.kts")
    }

    val deployAws by creating {
        group = "deploy"
        dependsOn(tfApply)
    }

    val deploy by creating {
        group = "deploy"
        dependsOn(deployAws)
    }

    tfDestroy {
        finalizedBy(clean)
        setAutoApprove(true)
    }
    val destroyAws by creating {
        group = "deploy"
        dependsOn(tfInit)
        dependsOn(tfDestroy)
//        outputs.upToDateWhen { false }
    }

    val destroy by creating {
        group = "deploy"
        dependsOn(destroyAws)
//        outputs.upToDateWhen { false }
    }

    clean {
        delete("$projectDir/out")
    }

}
