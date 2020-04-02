package com.crowdproj.main.common

interface IMainError {
    val id: String
    val field: String
    val title: String
    val description: String
    val level: MainErrorLevels
}
