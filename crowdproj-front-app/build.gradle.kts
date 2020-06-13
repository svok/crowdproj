plugins {
    id("org.ysb33r.terraform")
    id("org.ysb33r.terraform.remotestate.s3")
}
group = rootProject.group
version = rootProject.version

flutter {
}

terraform {
    val awsRegions: String by project
    val apiVersion: String by project
    val apiDomain: String by project
    val awsBucket: String by project
    val awsBucketPublic: String by rootProject.extra
    val awsBucketState: String by project

    variables {
        `var`("sourcePath", "$buildDir/web")
        `var`("region", awsRegions)
        `var`("baseName", "/pr/")
        `var`("bucketPublic", awsBucketPublic)
        map(mapOf<String, String>(
            "last_build_id" to "text/plain",
            "txt" to "text/plain",
            "html" to "text/html",
            "css" to "text/css",
            "jpg" to "image/jpeg",
            "png" to "image/png",
            "gif" to "image/gif",
            "jpeg" to "image/jpeg",
            "ttf" to "font/ttf",
            "js" to "application/javascript",
            "map" to "application/javascript",
            "json" to "application/json",
            "xml" to "text/xml",
            "ico" to "image/vnd.microsoft.icon"
        ), "mime_types")
        list("corsOrigins",
            "https://$apiVersion.$apiDomain",
            "https://$apiVersion-*.$apiDomain",
            "https://public.$apiDomain",
            "https://private.$apiDomain"
        )
    }
    remote {
        setPrefix("states-$apiVersion/state-private")
        s3 {
            setRegion(awsRegions)
            setBucket(awsBucketState)
        }
    }
    terraformSourceSets {
        get("main").apply {
            setSrcDir("${projectDir}/tf/${name}")
        }
    }
}

tasks {

    flutterPubUpgrade {
        dependsOn(project(":crowdproj-teams:front-teams").getTasksByName("build", false))
        dependsOn(project(":crowdproj-common:crowdproj-common-dt").getTasksByName("build", false))
    }

    val prepareConstants by creating {
        val awsUserPoolId: String by project
        val awsClientId: String by project
        val awsIdentityPoolId: String by project
        val awsRegions: String by project
        val awsCognitoEndpoint: String by project

        val crowdprojConstantsText = """
            class CrowdprojConstants {
              static const awsUserPoolId = '$awsUserPoolId';
              static const awsClientId = '$awsClientId';

              static const identityPoolId = '$awsIdentityPoolId';

              // Setup endpoints here:
              static const awsRegion = '$awsRegions';
              static const awsCognitoEndpoint = '$awsCognitoEndpoint';
            }
        """.trimIndent()
        file("$projectDir/lib/CrowdprojConstants.dart").writeText(text = crowdprojConstantsText)
    }

    flutterInit.get().dependsOn(prepareConstants)
    flutterBuildWeb.get().dependsOn(prepareConstants)
    flutterBuildAndroid.get().dependsOn(prepareConstants)
    flutterBuildIos.get().dependsOn(prepareConstants)
    flutterBuildLinux.get().dependsOn(prepareConstants)
    flutterBuildMacos.get().dependsOn(prepareConstants)
    flutterBuildWindows.get().dependsOn(prepareConstants)
    flutterBuildRunner.get().dependsOn(prepareConstants)

    create("build") {
        group = "build"
        dependsOn(flutterBuildWeb)
//        dependsOn(setWebArtifact)
    }

    create<Delete>("clean") {
        group = "build"
        delete(buildDir)
    }

    tfApply {
        dependsOn(flutterBuildWeb)
        dependsOn(":crowdproj-common:crowdproj-common-aws:deployAws")
        dependsOn(tfInit)
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
        setAutoApprove(true)
    }
    val destroyAws by creating {
        group = "deploy"
        dependsOn(tfInit)
        dependsOn(tfDestroy)
    }

    val destroy by creating {
        group = "deploy"
        dependsOn(destroyAws)
    }

}

