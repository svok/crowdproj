package com.crowdproj.common.aws.exceptions

class AwsParameterNotSet(parameter: String, among: Map<String, String>? = null) : Throwable(
    "Parameter is not set in AWS SSM: $parameter${
        among?.let { " among others: ${among.map { 
            "${it.key}=${it.value}"
        }.joinToString(",")}" }
    }"
)
