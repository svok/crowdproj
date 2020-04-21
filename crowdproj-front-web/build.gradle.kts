plugins {
    id("com.eden.orchidPlugin")
//    id("org.ysb33r.terraform.base")
    id("org.ysb33r.terraform")
//    id("org.ysb33r.terraform.remotestate.s3")
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

    implementation("io.github.javaeden.orchid:OrchidCore:$orchidVersion")
    orchidImplementation("io.github.javaeden.orchid:OrchidCore:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidPosts:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidPages:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidWiki:$orchidVersion")
//    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidNetlifyCMS:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidPluginDocs:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidSearch:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidWritersBlocks:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidSyntaxHighlighter:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidTaxonomies:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidFutureImperfect:$orchidVersion")
    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidBsDoc:$orchidVersion")
//    orchidRuntimeOnly("io.github.javaeden.orchid:OrchidAsciidoc:$orchidVersion")
}

val orchidDest = "$buildDir/docs"
val orchidContentDest = orchidDest

orchid {
    // Theme is required
    theme = "BsDoc"

    // The following properties are optional
    version = "${project.version}"
//    baseUrl = "{baseUrl}"                         // a baseUrl prepended to all generated links. Defaults to '/'
//    srcDir  = "path/to/new/source/directory"      // defaults to 'src/orchid/resources'
//    destDir = "path/to/new/destination/directory" // defaults to 'build/docs/orchid'
    runTask = "build"                             // specify a task to run with 'gradle orchidRun'
    destDir = orchidDest
}

terraform {
    val awsRegions: String by project
    val apiVersion: String by project
    val apiDomain: String by project
    val awsBucket: String by project

    val bucketState = awsBucket
    val bucketPublic = "$awsBucket.$apiVersion-public"

    variables {
        `var`("sourcePath", orchidContentDest)
        `var`("region", awsRegions)
        `var`("domainZone", apiDomain)
        `var`("domain", "$apiVersion.$apiDomain")
        `var`("bucketPublic", bucketPublic)
        `var`("enable_gzip", true)
        `var`("enable_health_check", false)
        map(mapOf<String, String>(
            "txt" to "text/plain",
            "html" to "text/html",
            "css" to "text/style",
            "jpg" to "image/jpeg",
            "jpeg" to "image/jpeg",
            "ttf" to "font/ttf",
            "js" to "application/javascript",
            "map" to "application/javascript",
            "json" to "application/json",
            "xml" to "text/xml",
            "ico" to "image/vnd.microsoft.icon"
        ), "mime_types")
//        `var`("stateTable", "arn:aws:dynamodb:us-east-1:709565996550:table/com.crowdproj.states")
//        `var`("health_check_alarm_sns_topics", "crowdproj-public-website-alarm")
    }
//    remote {
//        setPrefix("states-$apiVersion/state-public")
//        s3 {
//            setRegion(awsRegions)
//            setBucket(bucketState)
//        }
//    }
}

tasks {

    orchidBuild {
        inputs.dir("src")
        outputs.dir(orchidDest)
        doFirst {
            delete(orchidDest)
        }
    }

//    val conf = project.configurations.create("webDistConfig")
//    val setWebArtifact by creating {
//        dependsOn(orchidBuild)
//        artifacts.add(conf.name, fileTree("$buildDir/docs/orchid").dir)
//    }

//    val tfInit by getting {
//        dependsOn(or)
//    }
    tfInit {
//        dependsOn(orchidBuild)
    }
    tfApply {
//        dependsOn(orchidBuild)
    }

    clean {
        delete("$projectDir/out")
    }

}
