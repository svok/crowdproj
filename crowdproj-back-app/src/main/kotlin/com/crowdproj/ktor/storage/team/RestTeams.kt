package com.crowdproj.ktor.storage.team

import com.crowdproj.ktor.storage.common.toApiErrors
import com.crowdproj.main.team.TeamContext
import com.crowdproj.main.team.TeamService
import com.crowdproj.rest.Paths
import com.crowdproj.rest.apis.TeamApi
import com.crowdproj.rest.models.*
import io.ktor.application.call
import io.ktor.auth.OAuthAccessTokenResponse
import io.ktor.auth.authenticate
import io.ktor.auth.authentication
import io.ktor.http.HttpStatusCode
import io.ktor.locations.get
import io.ktor.response.respond
import io.ktor.routing.Routing
import io.ktor.routing.post
import io.ktor.routing.put
import io.ktor.routing.route
import java.time.Instant

fun Routing.restTeams() {

    val service = TeamService(storage = DynamoDbTeamsStorage)

    val teamResult = Team(
        id = "123-2345-456-567-sdflkgj",
        name = "Some Team",
        summary = "Some team summary",
        description = "some description",
        owner = Profile(
            id = "user-234-435609-345-dflk",
            alias = "mrJohns",
            fName = "John",
            mName = "W",
            lName = "Smith",
            email = "petrunya@ivanov.example",
            phone = "+7 999-999-9999"
//            profileStatus = Profile.ProfileStatus.profileActive
        ),
        photoUrls = arrayOf("https://crowdproj.com/profile/photos/123-2345-456-567-sdflkgj.jpg"),
        tags = arrayOf(
            Tag(
                id = "tag-234-25-fgh-345367",
                name = "Examples",
                description = "A special tag for example teams"
            ),
            Tag(id = "tag-234-25-fgh-334567", name = "Sports", description = "Mark teams related to sports")
        ),
        visibility = TeamVisibility.teamPublic,
        joinability = TeamJoinability.byUser,
        status = TeamStatus.active
    )

    route("/team") {
//        authenticate("crowdproj_auth") {
        // Create a team
        post {
            val timeStart = Instant.now()
//            val principal = call.authentication.principal<OAuthAccessTokenResponse>()

//            when (principal) {
//                null -> {
//                }
//                is OAuthAccessTokenResponse.OAuth1a -> {
//                }
//                is OAuthAccessTokenResponse.OAuth2 -> {
//                    principal.extraParameters
//                }
//            }
//            if (principal == null) {
//                call.respond(HttpStatusCode.Unauthorized)
//            } else {
            val timeEnd = Instant.now()
            val result = ApiResponseTeam(
                timeReceived = timeStart.toString(),
                timeFinished = timeEnd.toString(),
                status = ApiResponseTeam.Status.responseOk,
                errors = emptyArray(),
                data = arrayOf(teamResult)
            )
            call.respond(HttpStatusCode.OK, result)
//            }
        }

        // Update a team
        put {
            val timeStart = Instant.now()
//            val principal = call.authentication.principal<OAuthAccessTokenResponse>()

//            if (principal == null) {
//                call.respond(HttpStatusCode.Unauthorized)
//            } else {
            val timeEnd = Instant.now()
            val result = ApiResponseTeam(
                timeReceived = timeStart.toString(),
                timeFinished = timeEnd.toString(),
                status = ApiResponseTeam.Status.responseOk,
                errors = emptyArray(),
                data = arrayOf(teamResult)
            )
            call.respond(HttpStatusCode.OK, result)
//            }
        }
//        }
    }

    get<Paths.getTeamById> { param: Paths.getTeamById ->
        val timeStart = Instant.now()
        val context = TeamContext(requestTeamId = param.teamId)
        val result = try {
            service.getTeam(context)
            ApiResponseTeam(
                timeReceived = timeStart.toString(),
                timeFinished = Instant.now().toString(),
                status = ApiResponseTeam.Status.responseOk,
                errors = context.errors.toApiErrors().toTypedArray(),
                data = context.result.toApiResults().toTypedArray()
            )
        } catch (e: Exception) {
            ApiResponseTeam(
                timeReceived = timeStart.toString(),
                timeFinished = Instant.now().toString(),
                status = ApiResponseTeam.Status.responseOk,
                errors = arrayOf(
                    ApiError(
                        code = "error-handler",
                        field = null,
                        message = "Error in request handler logics",
                        description = "Request to buziness logics processor returned an error message: ${e.message}",
                        level = ApiError.Level.fatal
                    )
                ),
                data = arrayOf(teamResult)
            )
        }

        call.respond(HttpStatusCode.OK, result)
    }

//    TeamApi()
}
