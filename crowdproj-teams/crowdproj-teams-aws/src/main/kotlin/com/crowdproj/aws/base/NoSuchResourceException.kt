package com.crowdproj.aws.base

class NoSuchResourceException(resource: String) : Throwable(message = "No such resource: $resource") {

}
