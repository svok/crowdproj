package com.crowdproj.aws.handlers

import com.crowdproj.common.aws.IAwsHandler
import com.crowdproj.common.aws.IRequestContext
import com.crowdproj.common.aws.RequestContext
import com.crowdproj.common.aws.toError
import com.crowdproj.rest.teams.models.RestResponseStatus
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.crowdproj.teams.back.transport.rest.toApiError
import com.crowdproj.teams.back.transport.rest.toApiErrors
import com.crowdproj.teams.back.transport.rest.toApiResults
import com.crowdproj.teams.main.TeamContext
import java.time.Instant

abstract class TeamsBaseHandler<Rq, OC: RequestContext<Rq, RestResponseTeam>>: IAwsHandler {

    abstract suspend fun handleRequest(context: OC, iContext: TeamContext)

    override suspend fun exec(context: IRequestContext) {
        context as OC
        try {
            context.logger.info("TeamsBaseHandler: start")
            val iContext = TeamContext()

            handleRequest(context, iContext)
            context.logger.info("TeamsBaseHandler: $iContext")
            context.apply {
                response = RestResponseTeam(
                    timeReceived = context.timeStart.toString(),
                    data = iContext.result.toApiResults().toTypedArray(),
                    status = RestResponseStatus.responseOk,
                    errors = context.errors.takeIf { it.isNotEmpty() }?.toApiErrors()?.toTypedArray(),
                    timeFinished = Instant.now().toString()
                )
                responseCode = 200
            }
            context.logger.info("TeamsBaseHandler: done")

        } catch (e: Throwable) {
            context.logger.error("ERROR handling request in TeamsBaseHandler: $e")
            context.response = RestResponseTeam(
                timeReceived = context.timeStart.toString(),
                status = RestResponseStatus.responseError,
                errors = listOf(e.toError()).map { it.toApiError() }.toTypedArray(),
                timeFinished = Instant.now().toString()
            )
            context.responseCode = 500
        }
    }
}
