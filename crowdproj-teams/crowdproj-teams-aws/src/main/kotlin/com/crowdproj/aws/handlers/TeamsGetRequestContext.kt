package com.crowdproj.aws.handlers

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.crowdproj.aws.base.EmptyAwsLambdaContext
import com.crowdproj.aws.base.RequestContext
import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.Error
import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.rest.teams.models.RestResponseTeam
import java.time.Instant

data class TeamsGetRequestContext(
    override var status: ContextStatuses = ContextStatuses.none,
    override var request: RestQueryTeamGet = RestQueryTeamGet(),
    override var response: RestResponseTeam = RestResponseTeam(),
    override var errors: MutableList<Error> = mutableListOf(),
    override var timeStart: Instant = Instant.MIN,
    override var logger: ILogger = ILogger.NONE,
    override var requestInput: APIGatewayProxyRequestEvent = APIGatewayProxyRequestEvent(),
    override var requestContext: Context = EmptyAwsLambdaContext,
    override var requestBody: String = "",
    override var responseHeaders: MutableMap<String, String> = mutableMapOf(),
    override var responseBody: String = "",
    override var responseEncoded: Boolean = false,
    override var responseCode: Int = 0
): RequestContext<RestQueryTeamGet, RestResponseTeam>(
    status = status,
    request = request,
    response = response,
    timeStart = timeStart,
    logger = logger,
    errors = errors,
    requestInput = requestInput,
    responseHeaders = responseHeaders,
    requestContext = requestContext,
    requestBody = requestBody,
    responseBody = responseBody,
    responseEncoded = responseEncoded,
    responseCode = responseCode
)
