package com.crowdproj.common

data class Error(
    override val id: String = "",
    override val field: String = "",
    override val level: MainErrorLevels = MainErrorLevels.error,
    override val title: String = "",
    override val description: String = ""
): IMainError
