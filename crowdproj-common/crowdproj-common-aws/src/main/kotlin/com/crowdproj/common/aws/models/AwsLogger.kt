package com.crowdproj.common.aws.models

import com.amazonaws.services.lambda.runtime.LambdaLogger
import com.crowdproj.common.ILogger

class AwsLogger(
    val awsLogger: LambdaLogger
): ILogger {
    override fun trace(message: String) = log("TRACE", message)

    override fun debug(message: String) = log("DEBUG", message)

    override fun info(message: String) = log("INFO", message)

    override fun warning(message: String) = log("WARNING", message)

    override fun error(message: String) = log("ERROR", message)

    override fun fatal(message: String) = log("FATAL", message)

    private fun log(level: String, message: String) {
        awsLogger.log("$level : $message")
    }
}
