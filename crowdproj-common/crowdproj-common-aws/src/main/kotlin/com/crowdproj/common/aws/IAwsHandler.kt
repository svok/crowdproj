package com.crowdproj.common.aws

interface IAwsHandler {
    suspend fun exec(context: IRequestContext)
}
