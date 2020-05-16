package com.crowdproj.aws.base

import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamService
import com.crowdproj.rest.teams.models.ApiError
import com.crowdproj.rest.teams.models.ApiResponseStatus
import com.crowdproj.rest.teams.models.ApiResponseTeam
import com.crowdproj.teams.back.transport.rest.toApiErrors
import com.crowdproj.teams.back.transport.rest.toApiResults
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage
import java.time.Instant

abstract class TeamsAwsBaseHandler<T>(
    requestClass: Class<T>
) : AwsBaseHandler<T, ApiResponseTeam>(
    requestClass = requestClass
) {

    abstract suspend fun handler(oContext: TeamsRequestContext<T>, iContext: TeamContext)

    override suspend fun handlePost(context: RequestContext<T, ApiResponseTeam>): Unit = with(context) {
        val innerContext = TeamContext()
        handler(context as TeamsRequestContext<T>, innerContext)
        response = ApiResponseTeam(
            timeReceived = timeStart.toString(),
            timeFinished = Instant.now().toString(),
            status = ApiResponseStatus.responseOk,
            errors = innerContext.errors.toApiErrors().toTypedArray(),
            data = innerContext.result.toApiResults().toTypedArray()
        )
    }
    override suspend fun handleError(context: RequestContext<T, ApiResponseTeam>): Unit = with(context) {
        response = ApiResponseTeam(
            status = ApiResponseStatus.responseError,
            errors = arrayOf(resolveError(exception)),
            timeReceived = timeStart.toString(),
            timeFinished = Instant.now().toString()
        )
    }
    open suspend fun resolveError(e: Throwable?): ApiError = when(e) {
        else -> ApiError(
            code = "bad-request",
            message = e?.message ?: "Unknown error is occured",
            level = ApiError.Level.error
        )
    }

}