package com.crowdproj.aws.base

interface IAwsHandlerConfig {
    val handler: IAwsHandler
    val contextCreator: () -> IRequestContext
    val prepareResult: (context: IRequestContext) -> Unit
}
