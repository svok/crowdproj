package com.crowdproj.common.aws.exceptions

class AwsParameterNotSet(parameter: String) : Throwable(
    "Parameter is not set in AWS SSM: $parameter"
)
