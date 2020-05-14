package com.crowdproj.aws.base

import com.crowdproj.common.ILogger
import com.fasterxml.jackson.databind.JsonNode
import java.time.Instant

open class RequestContext<T, R>(
    open var requestData: JsonNode,
    open var request: T,
    open var response: R,
    open var exception: Throwable?,
    open var timeStart: Instant,
    open var logger: ILogger
) {
}