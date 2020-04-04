package com.crowdproj.ktor.page

import io.ktor.http.content.*
import io.ktor.routing.Routing
import java.io.File

fun Routing.siteStatics() {
    static {
        staticRootFolder = File("build/web-static")
        files("main")
        default("main/index.html")
        static("pra") {
            staticRootFolder = File("build/web-static/pra")
            static("assets") {
                static("assets") { files("assets/assets") }
                static("fonts") { files("assets/fonts") }
                static("packages") { files("assets/packages") }
                file("AssetManifest.json", "assets/AssetManifest.json")
                file("FontManifest.json", "assets/FontManifest.json")
            }
            file("flutter_service_worker.js")
            file("main.dart.js")
            file("index.html")
            default("index.html")
        }
    }
}
