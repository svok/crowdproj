package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.LambdaLogger

object EmptyAwsLambdaLogger : LambdaLogger {
    override fun log(message: String?) {}
    override fun log(message: ByteArray?) {}
}
