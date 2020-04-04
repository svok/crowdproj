package com.crowdproj.main.team.errors

import com.crowdproj.common.IMainError
import com.crowdproj.common.MainErrorLevels


data class ErrorStorage(
    val message: String = "",
    override val level: MainErrorLevels = MainErrorLevels.fatal
): IMainError {
    override val id: String = "error-storage"
    override val field: String = ""
    override val title: String = "Storage error"
    override val description: String = "Request to inner storage returned an error message: $message"

    companion object {
        fun create(message: String = "", level: MainErrorLevels = MainErrorLevels.fatal) = ErrorStorage(
            message = message,
            level = level
        )
    }
}
