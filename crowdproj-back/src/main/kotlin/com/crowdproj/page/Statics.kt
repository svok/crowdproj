package com.crowdproj.page

import io.ktor.http.content.*
import io.ktor.routing.Routing
import java.io.File

fun Routing.siteStatics() {
    static {
        staticRootFolder = File("build/web-static/pra")
        static("pra") {
            static("assets") {
                static("assets") {
                    files("assets/assets")
                }
                static("fonts") {
                    file("MaterialIcons-Regular.ttf","assets/fonts/MaterialIcons-Regular.ttf")
                    static("Roboto") {
                        files("assets/fonts/Roboto")
                    }
                }
                static("packages") {
                    static("flutter_markdown") {
                        static("assets") {
                            file("logo.png", "assets/packages/flutter_markdown/assets/logo.png")
                        }
                    }
                    static("font_awesome_flutter") {
                        static("lib") {
                            static("fonts") {
                                file("fa-brands-400.ttf", "assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf")
                                file("fa-regular-400.ttf", "assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf")
                                file("fa-solid-900.ttf", "assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf")
                            }
                        }
                    }
                }
                file("AssetManifest.json", "assets/AssetManifest.json")
                file("FontManifest.json", "assets/FontManifest.json")
            }
            file("flutter_service_worker.js")
            file("main.dart.js")
            file("index.html")
            default("index.html")
        }
    }

    static {
        staticRootFolder = File("src/main/static")

        static("css") {
            file("shortener.css", "css/shortener.css")
        }

        static("js") {
            file("shortener.js", "js/shortener.js")
        }

//        static("pra") {
//            files("assets")
//            file("flutter_service_worker.js")
//            file("main.dart.js")
//            file("index.html")
//            default("index.html")
//        }

        file("favicon.apng", "favicon.apng")
    }
}
