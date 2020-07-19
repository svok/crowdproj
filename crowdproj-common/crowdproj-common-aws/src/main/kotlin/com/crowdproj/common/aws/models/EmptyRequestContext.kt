package com.crowdproj.common.aws.models

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.Error
import com.crowdproj.common.ILogger
import com.crowdproj.common.aws.IRequestContext
import java.time.Instant

data class EmptyRequestContext(
    override val requestInput: APIGatewayProxyRequestEvent = APIGatewayProxyRequestEvent(),
    override val errors: MutableList<Error> = mutableListOf(),
    override val timeStart: Instant = Instant.now(),
    override val logger: ILogger = ILogger.NONE,
    override val responseHeaders: MutableMap<String, String> = mutableMapOf(),
    override val responseBody: String = "",
    override val responseEncoded: Boolean = false,
    override val responseCode: Int = 500,
    override val requestContext: Context = EmptyAwsLambdaContext,
    override var status: ContextStatuses = ContextStatuses.none,
    override val requestBody: String = ""
): IRequestContext
