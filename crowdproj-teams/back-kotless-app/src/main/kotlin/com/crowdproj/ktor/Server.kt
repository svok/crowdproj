package com.crowdproj.ktor

//import io.ktor.html.respondHtml
import com.crowdproj.rest.teams.infrastructure.ApiKeyCredential
import com.crowdproj.rest.teams.infrastructure.ApiPrincipal
import com.crowdproj.rest.teams.infrastructure.apiKeyAuth
import com.typesafe.config.ConfigFactory
import io.kotless.dsl.ktor.Kotless
import io.ktor.application.Application
import io.ktor.application.install
import io.ktor.auth.Authentication
import io.ktor.auth.oauth
import io.ktor.client.HttpClient
import io.ktor.client.engine.apache.Apache
import io.ktor.config.HoconApplicationConfig
import io.ktor.features.CORS
import io.ktor.features.ContentNegotiation
import io.ktor.gson.GsonConverter
import io.ktor.http.ContentType
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpMethod
import io.ktor.locations.Locations
import io.ktor.routing.routing
import org.slf4j.LoggerFactory
import java.time.Duration

internal val settings = HoconApplicationConfig(ConfigFactory.defaultApplication(HTTP::class.java.classLoader))
object HTTP {
    val client = HttpClient(Apache)
}


class Server : Kotless() {
    private val logger = LoggerFactory.getLogger(Server::class.java)

    override fun prepare(app: Application): Unit = with(app) {

        install(Locations)
        install(ContentNegotiation) {
            register(ContentType.Application.Json, GsonConverter())
        }
        install(CORS) {
//            method(HttpMethod.Options)
//            header(HttpHeaders.XForwardedProto)
            anyHost()
            header("*")
//            headers.addAll(HttpHeaders.UnsafeHeaders)
            methods.addAll(HttpMethod.DefaultMethods)
//            host("*", schemes = listOf("http", "https"))
//            header(HttpHeaders.AccessControlAllowHeaders)
//            header(HttpHeaders.AccessControlAllowMethods)
//            header(HttpHeaders.AccessControlAllowCredentials)
//            header(HttpHeaders.AccessControlAllowCredentials)
//            host("my-host")
//             host("my-host:80")
//             host("my-host", subDomains = listOf("www"))
//             host("my-host", schemes = listOf("http", "https"))
            allowSameOrigin = true
            allowCredentials = true
            allowNonSimpleContentTypes = true
            maxAge = Duration.ofDays(1)
        }
        install(Authentication) {
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


        routing {
            restTeams()
        }
    }
}
