package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestStreamHandler
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
        context.logger.log("CRPWDPROJ GOT REQIEST")
        val localContext = createContext()
        localContext.timeStart = Instant.now()
        val objectMapper = ObjectMapper()
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)

        runBlocking {
            val obj = try {
                localContext.request = objectMapper.readValue<T>(inputStream, requestClass) ?: throw EmptyDataException()
                context.logger.log("CRPWDPROJ GOT QUERY: ${localContext.request}")
                handlePost(localContext)
            } catch (e: EmptyDataException) {
                localContext.exception = e
                handleError(localContext)
            } catch (e: Exception) {
                localContext.exception = e
                handleError(localContext)
            }
        }

        val responseObject = AwsResponse(
                statusCode = 200,
                headers = mutableMapOf(),
                body = objectMapper.writeValueAsString(localContext.response)
        )
        val responseJson = objectMapper.writeValueAsString(responseObject)
        val writer = OutputStreamWriter(outputStream, "UTF-8")
        writer.write(responseJson.toString())
        writer.close()
    }

    abstract fun createContext(): RequestContext<T, R>
    abstract suspend fun handlePost(context: RequestContext<T, R>)
    abstract suspend fun handleError(context: RequestContext<T, R>)
}