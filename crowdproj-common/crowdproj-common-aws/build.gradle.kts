plugins {
    id("org.ysb33r.terraform")
    id("org.ysb33r.terraform.remotestate.s3")
}

group = rootProject.group
version = rootProject.version

val awsRegions: String by project
val apiVersion: String by project
val apiDomain: String by project
val awsBucket: String by project
val awsBucketState: String by project

val awsBucketPublic: String by rootProject.extra
val awsBucketPrivate: String by rootProject.extra
val domainPublic: String by rootProject.extra

terraform {
    variables {
        `var`("region", awsRegions)
        `var`("domainZone", apiDomain)
//        `var`("domain", "$serviceAlias.$apiDomain")
        `var`("domain", domainPublic)
        `var`("bucketPublic", awsBucketPublic)
        `var`("bucketPrivate", awsBucketPrivate)
        `var`("enable_gzip", true)
        `var`("enable_health_check", false)
//        `var`("stateTable", "arn:aws:dynamodb:us-east-1:709565996550:table/com.crowdproj.states")
//        `var`("health_check_alarm_sns_topics", "crowdproj-public-website-alarm")
    }
    remote {
        setPrefix("states-$apiVersion/state-common")
        s3 {
            setRegion(awsRegions)
            setBucket(awsBucketState)
        }
    }
}

tasks {

    tfApply {
        dependsOn(tfInit)
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

    val clean by creating(Delete::class) {
        delete(buildDir)
    }

    tfDestroy {
        outputs.upToDateWhen { false }
        setAutoApprove(true)
        finalizedBy(clean)
    }
    val destroyAws by creating {
        group = "deploy"
        dependsOn(tfInit)
        dependsOn(tfDestroy)
        dependsOn(":crowdproj-teams:crowdproj-teams-aws:destroyAws")
        dependsOn(":crowdproj-front-app:destroyAws")
        dependsOn(":crowdproj-front-web:destroyAws")
//        outputs.upToDateWhen { false }
    }

    val destroy by creating {
        group = "deploy"
        dependsOn(destroyAws)
//        outputs.upToDateWhen { false }
    }

}
