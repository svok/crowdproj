package com.crowdproj

import com.crowdproj.page.Main.main
import io.kotless.dsl.ktor.Kotless
import com.crowdproj.page.siteStatics
import com.crowdproj.storage.URLStorage
import io.ktor.application.Application
import io.ktor.application.call
import io.ktor.html.respondHtml
import io.ktor.http.HttpStatusCode
import io.ktor.response.respond
import io.ktor.response.respondRedirect
import io.ktor.response.respondText
import io.ktor.routing.get
import io.ktor.routing.routing
import org.apache.commons.validator.routines.UrlValidator
import org.slf4j.LoggerFactory

class Server : Kotless() {
    private val logger = LoggerFactory.getLogger(Server::class.java)

    override fun prepare(app: Application) {
        app.routing {
            siteStatics()

            get("/") {
                call.respondHtml { main() }
            }

            get("/r") {
                val k = call.parameters["k"] ?: ""

                val url = URLStorage.getByCode(k)
                if (url == null) {
                    call.respond(HttpStatusCode.NotFound, "Unknown short URL")
                } else {
                    call.respondRedirect(url)
                }
            }

            get("/shorten") {
                val value = call.parameters["value"] ?: ""

                logger.info("URL for shortening $value")

                val url = if (value.contains("://").not()) "https://$value" else value

                if (UrlValidator.getInstance().isValid(url).not()) {
                    call.respondText { "Non valid URL" }
                } else {
                    val code = URLStorage.getByUrl(url) ?: URLStorage.createCode(url)
                    call.respondText { "https://ktor.short.kotless.io/r?k=$code" }
                }
            }

        }
    }
}
