package com.crowdproj.common.aws

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.Error
import com.crowdproj.common.ILogger
import java.time.Instant

open class RequestContext<T, R>(
    open var request: T,
    open var response: R,
    override var timeStart: Instant,
    override var logger: ILogger,
    override var requestInput: APIGatewayProxyRequestEvent,
    override var requestContext: Context,
    override var requestBody: String,
    override val errors: MutableList<Error>,
    override var responseHeaders: MutableMap<String, String>,
    override var responseBody: String,
    override var responseEncoded: Boolean,
    override var responseCode: Int,
    override var status: ContextStatuses
) : IRequestContext {

}
