package com.crowdproj.common.aws.exceptions

class NoSuchResourceException(resource: String) : Throwable(message = "No such resource: $resource") {

}
