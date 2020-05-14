package com.crowdproj.teams.storage.common.exceptions

class DbClientException(val obj: Any, e: Throwable) : Exception("DB client operation failure for $obj", e) {

}
