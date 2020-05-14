package com.crowdproj.common

interface ILogger {
    fun trace(message: String)
    fun debug(message: String)
    fun info(message: String)
    fun warning(message: String)
    fun error(message: String)
    fun fatal(message: String)

    companion object {
        val NONE = object : ILogger {
            override fun trace(message: String) {}

            override fun debug(message: String) {}

            override fun info(message: String) {}

            override fun warning(message: String) {}

            override fun error(message: String) {}

            override fun fatal(message: String) {}
        }
    }
}