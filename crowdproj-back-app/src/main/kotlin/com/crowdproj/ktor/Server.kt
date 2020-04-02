package com.crowdproj.ktor

import io.ktor.client.engine.apache.Apache
import com.crowdproj.page.restProfiles
import com.crowdproj.page.restTeams
import io.kotless.dsl.ktor.Kotless
import com.crowdproj.page.siteStatics
import com.crowdproj.rest.infrastructure.ApiKeyCredential
import com.crowdproj.rest.infrastructure.ApiPrincipal
import com.crowdproj.rest.infrastructure.apiKeyAuth
import com.crowdproj.storage.TeamsStorage
import com.typesafe.config.ConfigFactory
import io.ktor.application.Application
import io.ktor.locations.Locations
import io.ktor.application.call
import io.ktor.application.install
import io.ktor.auth.Authentication
import io.ktor.auth.oauth
import io.ktor.client.HttpClient
import io.ktor.config.HoconApplicationConfig
import io.ktor.features.ContentNegotiation
import io.ktor.gson.GsonConverter
import io.ktor.http.ContentType
//import io.ktor.html.respondHtml
import io.ktor.http.HttpStatusCode
import io.ktor.response.respond
import io.ktor.response.respondRedirect
import io.ktor.response.respondText
import io.ktor.routing.get
import io.ktor.routing.routing
import org.apache.commons.validator.routines.UrlValidator
import org.slf4j.LoggerFactory

internal val settings = HoconApplicationConfig(ConfigFactory.defaultApplication(HTTP::class.java.classLoader))
object HTTP {
    val client = HttpClient(Apache)
}


class Server : Kotless() {
    private val logger = LoggerFactory.getLogger(Server::class.java)

    override fun prepare(app: Application) {

        app.install(Locations)
        app.install(ContentNegotiation) {
            register(ContentType.Application.Json, GsonConverter())
        }
        app.install(Authentication) {
            // "Implement API key auth (api_key) for parameter name 'api_key'."
            apiKeyAuth("api_key") {
                validate { apikeyCredential: ApiKeyCredential ->
                    when {
                        apikeyCredential.value == "keyboardcat" -> ApiPrincipal(apikeyCredential)
                        else -> null
                    }
                }
            }
            oauth("crowdproj_auth") {
                client = HttpClient(Apache)
                providerLookup = { ApplicationAuthProviders["crowdproj_auth"] }
                urlProvider = { _ ->
                    // TODO: define a callback url here.
                    "/"
                }
            }
        }


        app.routing {
            siteStatics()
            restProfiles()
            restTeams()

//            get("/") {
//                call.respondHtml { main() }
//            }

            get("/r") {
                val k = call.parameters["k"] ?: ""

                val url = TeamsStorage.getByCode(k)
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
                    val code = TeamsStorage.getByUrl(url) ?: TeamsStorage.createCode(url)
                    call.respondText { "https://ktor.short.kotless.io/r?k=$code" }
                }
            }

        }
    }
}
