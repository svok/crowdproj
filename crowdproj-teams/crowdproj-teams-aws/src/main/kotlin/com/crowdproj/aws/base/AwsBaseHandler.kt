package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestStreamHandler
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.registerKotlinModule
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
        context.logger.log("CROWDPROJ GOT REQIEST")
        val localContext = createContext()
            .apply {
                timeStart = Instant.now()
                logger = AwsLogger(context.logger)
            }
        val objectMapper = ObjectMapper()
            .registerKotlinModule()
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)

        runBlocking {
            val obj = try {
                val json = inputStream.bufferedReader().use { it.readText() }
                context.logger.log("LAMBDA GOT $json")
//                localContext.request = objectMapper.readValue<T>(inputStream, requestClass) ?: throw EmptyDataException()
                val receivedRecord = objectMapper.readTree(json) ?: throw EmptyDataException()
                val body = receivedRecord["body"]?.asText() ?: ""
                with(localContext) {
                    requestData = receivedRecord
                    request = objectMapper.readValue(body, requestClass) ?: throw EmptyDataException()
                }
                context.logger.log("CRPWDPROJ GOT QUERY: ${localContext.request}")
                handlePost(localContext)
            } catch (e: EmptyDataException) {
                context.logger.log(e.toString())
                localContext.exception = e
                handleError(localContext)
            } catch (e: Exception) {
                context.logger.log(e.toString())
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