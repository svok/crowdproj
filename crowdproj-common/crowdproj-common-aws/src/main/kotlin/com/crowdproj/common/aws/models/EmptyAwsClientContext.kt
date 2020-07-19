package com.crowdproj.common.aws.models

import com.amazonaws.services.lambda.runtime.Client
import com.amazonaws.services.lambda.runtime.ClientContext
import com.crowdproj.common.aws.models.EmptyAwsClient

object EmptyAwsClientContext: ClientContext {
    override fun getCustom(): MutableMap<String, String> = mutableMapOf()
    override fun getEnvironment(): MutableMap<String, String> = mutableMapOf()
    override fun getClient(): Client = EmptyAwsClient

}
