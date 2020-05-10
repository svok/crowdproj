package com.crowdproj.aws.base

import java.time.Instant

open class RequestContext<T, R>(
    open var request: T,
    open var response: R,
    open var exception: Throwable?,
    open var timeStart: Instant
) {
}