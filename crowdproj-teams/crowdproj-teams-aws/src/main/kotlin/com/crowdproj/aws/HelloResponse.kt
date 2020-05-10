package com.crowdproj.aws

data class HelloResponse(val message: String, val input: Map<String, Any>) : Response()
