package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.crowdproj.common.ILogger
import java.time.Instant

class HandlerConfig() {
    var timeStart = Instant.now()!!
    var resource: String = ""
    var requestInput: APIGatewayProxyRequestEvent = APIGatewayProxyRequestEvent()
    var requestContext: Context = EmptyAwsLambdaContext
    var requestBody = ""
    var logger = ILogger.NONE

    var responseHeaders: MutableMap<String, String> = mutableMapOf()
}
