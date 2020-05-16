package com.crowdproj.aws.base

import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamService
import com.crowdproj.rest.teams.models.RestError
import com.crowdproj.rest.teams.models.RestResponseStatus
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.crowdproj.teams.back.transport.rest.toApiErrors
import com.crowdproj.teams.back.transport.rest.toApiResults
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage
import java.time.Instant

abstract class TeamsAwsBaseHandler<T>(
    requestClass: Class<T>
) : AwsBaseHandler<T, RestResponseTeam>(
    requestClass = requestClass
) {

    abstract suspend fun handler(oContext: TeamsRequestContext<T>, iContext: TeamContext)

    override suspend fun handlePost(context: RequestContext<T, RestResponseTeam>): Unit = with(context) {
        val innerContext = TeamContext()
        handler(context as TeamsRequestContext<T>, innerContext)
        response = RestResponseTeam(
            timeReceived = timeStart.toString(),
            timeFinished = Instant.now().toString(),
            status = RestResponseStatus.responseOk,
            errors = innerContext.errors.toApiErrors().toTypedArray(),
            data = innerContext.result.toApiResults().toTypedArray()
        )
    }
    override suspend fun handleError(context: RequestContext<T, RestResponseTeam>): Unit = with(context) {
        response = RestResponseTeam(
            status = RestResponseStatus.responseError,
            errors = arrayOf(resolveError(exception)),
            timeReceived = timeStart.toString(),
            timeFinished = Instant.now().toString()
        )
    }
    open suspend fun resolveError(e: Throwable?): RestError = when(e) {
        else -> RestError(
            code = "bad-request",
            message = e?.message ?: "Unknown error is occured",
            level = RestError.Level.error
        )
    }

}