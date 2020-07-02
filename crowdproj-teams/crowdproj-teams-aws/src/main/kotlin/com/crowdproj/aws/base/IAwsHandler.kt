package com.crowdproj.aws.base

interface IAwsHandler {
    suspend fun exec(context: IRequestContext)
}
