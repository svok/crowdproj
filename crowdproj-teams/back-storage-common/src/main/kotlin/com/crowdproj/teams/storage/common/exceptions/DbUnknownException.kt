package com.crowdproj.teams.storage.common.exceptions

class DbUnknownException(val obj: Any, e: Throwable) : Exception("Unknown DB operation failure for $obj", e) {

}
