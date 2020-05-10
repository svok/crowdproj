package com.crowdproj.aws.storage

import com.crowdproj.common.IMainError
import com.crowdproj.common.MainErrorLevels
import com.crowdproj.rest.teams.models.ApiError


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

