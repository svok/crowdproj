package com.crowdproj.ktor.teams

//import io.ktor.html.respondHtml
import com.crowdproj.ktor.page.siteStatics
import com.crowdproj.ktor.storage.profile.restProfiles
import com.crowdproj.ktor.storage.team.restTeams
import com.crowdproj.rest.infrastructure.ApiKeyCredential
import com.crowdproj.rest.infrastructure.ApiPrincipal
import com.crowdproj.rest.infrastructure.apiKeyAuth
import com.typesafe.config.ConfigFactory
import io.kotless.dsl.ktor.Kotless
import io.ktor.application.Application
import io.ktor.application.install
import io.ktor.auth.Authentication
import io.ktor.auth.oauth
import io.ktor.client.HttpClient
import io.ktor.client.engine.apache.Apache
import io.ktor.config.HoconApplicationConfig
import io.ktor.features.ContentNegotiation
import io.ktor.gson.GsonConverter
import io.ktor.http.ContentType
import io.ktor.locations.Locations
import io.ktor.routing.routing
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
        }
    }
}
