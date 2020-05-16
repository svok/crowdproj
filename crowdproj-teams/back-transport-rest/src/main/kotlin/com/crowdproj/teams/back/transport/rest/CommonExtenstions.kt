package com.crowdproj.teams.back.transport.rest

import com.crowdproj.common.IMainError
import com.crowdproj.common.MainErrorLevels
import com.crowdproj.rest.teams.models.RestError


fun Collection<IMainError>.toApiErrors() = this.map { it.toApiError() }

fun IMainError.toApiError() = RestError(
    code = id,
    field = field,
    message = title,
    description = description,
    level = level.toApiErrorLevel()
)

fun MainErrorLevels.toApiErrorLevel(): RestError.Level = when(this) {
    MainErrorLevels.fatal -> RestError.Level.fatal
    MainErrorLevels.error -> RestError.Level.error
    MainErrorLevels.warning -> RestError.Level.warning
    MainErrorLevels.info -> RestError.Level.info
    MainErrorLevels.hint -> RestError.Level.hint
}

