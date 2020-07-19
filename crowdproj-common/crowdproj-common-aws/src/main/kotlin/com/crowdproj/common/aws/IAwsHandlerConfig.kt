package com.crowdproj.common.aws

interface IAwsHandlerConfig {
    val handler: IAwsHandler
    val contextCreator: () -> IRequestContext
    val prepareResult: (context: IRequestContext) -> Unit
}
