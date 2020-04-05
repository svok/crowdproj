package com.crowdproj.ktor

import com.crowdproj.ktor.storage.*
import com.crowdproj.main.team.TeamContext
import com.crowdproj.main.team.TeamService
import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.rest.teams.models.ApiError
import com.crowdproj.rest.teams.models.ApiQueryTeamGet
import com.crowdproj.rest.teams.models.ApiQueryTeamSave
import com.crowdproj.rest.teams.models.ApiResponseTeam
import io.kotless.PermissionLevel
import io.kotless.dsl.lang.DynamoDBTable
import io.ktor.application.ApplicationCall
import io.ktor.application.call
import io.ktor.http.HttpStatusCode
import io.ktor.request.receive
import io.ktor.response.respond
import io.ktor.routing.Routing
import io.ktor.routing.post
import io.ktor.util.pipeline.PipelineContext
import java.time.Instant

val service = TeamService(storage = DynamoDbTeamsStorage)

fun Routing.restTeams() {

    post("/teams/create") {
        handleRequest {
            val request = call.receive<ApiQueryTeamSave>()
            it.requestTeam = request.data?.toMain() ?: TeamModel.NONE
            service.createTeam(it)
        }
    }

    // Update a team
    post("/teams/update") {
        handleRequest {
            val request = call.receive<ApiQueryTeamSave>()
            it.requestTeam = request.data?.toMain() ?: TeamModel.NONE
            service.updateTeam(it)
        }

//        }
    }

    post("/teams/get") {
        handleRequest {
            val request = call.receive<ApiQueryTeamGet>()
            it.requestTeamId = request.teamId ?: ""
            service.getTeam(it)
        }
    }

//    TeamApi()
}

private suspend fun PipelineContext<Unit, ApplicationCall>.handleRequest(
    handler: suspend (context: TeamContext) -> Unit
) {
    val timeStart = Instant.now()
//        authenticate("crowdproj_auth") {
    // Create a team
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
    val response = try {
        val context = TeamContext()
        handler(context)
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
            data = arrayOf()
        )
    }
    call.respond(HttpStatusCode.OK, response)
}
