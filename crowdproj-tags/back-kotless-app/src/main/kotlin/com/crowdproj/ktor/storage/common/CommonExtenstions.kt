package com.crowdproj.ktor.storage.common

import com.crowdproj.main.common.IMainError
import com.crowdproj.main.common.MainErrorLevels
import com.crowdproj.rest.models.ApiError

fun Collection<IMainError>.toApiErrors() = this.map { it.toApiError() }

fun IMainError.toApiError() = ApiError(
    code = id,
    field = field,
    message = title,
    description = description,
    level = level.toApiErrorLevel()
)

fun MainErrorLevels.toApiErrorLevel(): ApiError.Level = when(this) {
    MainErrorLevels.fatal -> ApiError.Level.fatal
    MainErrorLevels.error -> ApiError.Level.error
    MainErrorLevels.warning -> ApiError.Level.warning
    MainErrorLevels.info -> ApiError.Level.info
    MainErrorLevels.hint -> ApiError.Level.hint
}

