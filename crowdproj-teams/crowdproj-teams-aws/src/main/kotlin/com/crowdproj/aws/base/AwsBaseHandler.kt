package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestStreamHandler
import com.crowdproj.rest.teams.models.ApiError
import com.crowdproj.rest.teams.models.ApiResponseStatus
import com.crowdproj.rest.teams.models.ApiResponseTeam
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import kotlinx.coroutines.runBlocking
import java.io.InputStream
import java.io.OutputStream
import java.io.OutputStreamWriter
import java.time.Instant


abstract class AwsBaseHandler<T, R>(
    val requestClass: Class<T>
) : RequestStreamHandler {

    override fun handleRequest(
        inputStream: InputStream,
        outputStream: OutputStream,
        context: Context
    ) {
        val context = createContext()
        context.timeStart = Instant.now()
        val objectMapper = ObjectMapper()
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)

        runBlocking {
            val obj = try {
                context.request = objectMapper.readValue<T>(inputStream, requestClass) ?: throw EmptyDataException()
                handlePost(context)
            } catch (e: EmptyDataException) {
                context.exception = e
                handleError(context)
            } catch (e: Exception) {
                context.exception = e
                handleError(context)
            }
        }

        val responseJson = objectMapper.writeValueAsString(context.response)
        val writer = OutputStreamWriter(outputStream, "UTF-8");
        writer.write(responseJson.toString())
        writer.close()
    }

    abstract fun createContext(): RequestContext<T, R>
    abstract suspend fun handlePost(context: RequestContext<T, R>)
    abstract suspend fun handleError(context: RequestContext<T, R>)
}