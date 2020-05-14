package com.crowdproj.teams.storage.common.exceptions

class DbServiceException(val obj: Any, e: Throwable) : Exception("DB service operation failure for $obj", e) {

}
