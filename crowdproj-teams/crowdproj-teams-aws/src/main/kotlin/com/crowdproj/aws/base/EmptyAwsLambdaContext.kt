package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.ClientContext
import com.amazonaws.services.lambda.runtime.CognitoIdentity
import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.LambdaLogger

object EmptyAwsLambdaContext : Context {
    override fun getAwsRequestId(): String = ""
    override fun getLogStreamName(): String = ""
    override fun getClientContext(): ClientContext = EmptyAwsClientContext
    override fun getFunctionName(): String = ""
    override fun getRemainingTimeInMillis(): Int = -1
    override fun getLogger(): LambdaLogger = EmptyAwsLambdaLogger
    override fun getInvokedFunctionArn(): String = ""
    override fun getMemoryLimitInMB(): Int = -1
    override fun getLogGroupName(): String = ""
    override fun getFunctionVersion(): String = ""
    override fun getIdentity(): CognitoIdentity = EmptyAwsCognitoIdentity
}
