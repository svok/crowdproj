plugins {
    kotlin("jvm")
}

group = rootProject.group
version = rootProject.version

dependencies {
    val ktorVersion: String by project
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("io.ktor:ktor-server-netty:$ktorVersion")
    implementation("io.ktor:ktor-metrics:$ktorVersion")
    implementation("io.ktor:ktor-locations:$ktorVersion")
    implementation("io.ktor:ktor-gson:$ktorVersion")
    implementation("io.ktor:ktor-client-core:$ktorVersion")
    implementation("io.ktor:ktor-client-apache:$ktorVersion")
//    implementation("ch.qos.logback:logback-classic:1.2.1")

}

sourceSets {
    main {
        java {
            srcDir("src")
//            exclude("**/apis/**")
        }
    }
}

tasks {
    compileKotlin.get().dependsOn(
        parent!!.getTasksByName(
            "generateKotlinModels",
            false
        )
    )
}

