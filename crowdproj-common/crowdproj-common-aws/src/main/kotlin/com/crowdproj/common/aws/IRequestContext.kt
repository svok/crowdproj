package com.crowdproj.common.aws

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.Error
import com.crowdproj.common.ILogger
import java.time.Instant

interface IRequestContext {
    var status: ContextStatuses
    val requestInput: APIGatewayProxyRequestEvent
    val requestContext: Context
    val requestBody: String
    val errors: MutableList<Error>
    val timeStart: Instant
    val logger: ILogger
    val responseHeaders: MutableMap<String,String>
    val responseBody: String
    val responseEncoded: Boolean
    val responseCode: Int
}
