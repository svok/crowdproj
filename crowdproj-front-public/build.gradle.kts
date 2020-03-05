plugins {
    id("com.eden.orchidPlugin")
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

orchid {
    // Theme is required
    theme = "BsDoc"

    // The following properties are optional
    version = "${project.version}"
//    baseUrl = "{baseUrl}"                         // a baseUrl prepended to all generated links. Defaults to '/'
//    srcDir  = "path/to/new/source/directory"      // defaults to 'src/orchid/resources'
//    destDir = "path/to/new/destination/directory" // defaults to 'build/docs/orchid'
    runTask = "build"                             // specify a task to run with 'gradle orchidRun'
}

tasks {

    orchidBuild {
        inputs.dir("src")
        outputs.dir("$buildDir/docs")
        doFirst {
            delete("$buildDir/docs")
        }
    }

    val conf = project.configurations.create("webDistConfig")
    val setWebArtifact by creating {
        dependsOn(orchidBuild)
        artifacts.add(conf.name, fileTree("$buildDir/docs/orchid").dir)
    }

}
