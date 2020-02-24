package com.crowdproj.page

import io.ktor.http.content.*
import io.ktor.routing.Routing
import java.io.File

fun Routing.siteStatics() {
    static("pra") {
        files("build/web-static")
        default(File("build/web-static/index.html"))
    }
    static {
        staticRootFolder = File("src/main/static")

        static("css") {
            file("shortener.css", "css/shortener.css")
        }

        static("js") {
            file("shortener.js", "js/shortener.js")
        }

        file("favicon.apng", "favicon.apng")
    }
}
