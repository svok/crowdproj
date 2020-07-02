package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Client

object EmptyAwsClient: Client {
    override fun getAppVersionCode(): String = ""
    override fun getAppPackageName(): String = ""
    override fun getAppTitle(): String = ""
    override fun getInstallationId(): String = ""
    override fun getAppVersionName(): String = ""
}
