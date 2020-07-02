package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Client
import com.amazonaws.services.lambda.runtime.ClientContext

object EmptyAwsClientContext: ClientContext {
    override fun getCustom(): MutableMap<String, String> = mutableMapOf()
    override fun getEnvironment(): MutableMap<String, String> = mutableMapOf()
    override fun getClient(): Client = EmptyAwsClient

}
