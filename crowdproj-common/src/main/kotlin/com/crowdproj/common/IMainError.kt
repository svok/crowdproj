package com.crowdproj.common

interface IMainError {
    val id: String
    val field: String
    val title: String
    val description: String
    val level: MainErrorLevels
}
