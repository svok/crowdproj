package com.crowdproj.common.aws.models

data class AwsResponse(
    val isBase64Encoded: Boolean = false,
    val statusCode: Int = 200,
    val headers: Map<String, Any?> = mutableMapOf(),
    val body: String = ""
)
