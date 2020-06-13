package com.crowdproj.aws.base

import com.amazonaws.internal.SdkInternalList
import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestStreamHandler
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagementClientBuilder
import com.amazonaws.services.simplesystemsmanagement.model.GetParametersRequest
import com.amazonaws.services.simplesystemsmanagement.model.Parameter
import com.crowdproj.aws.CrowdprojConstants
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

    protected val parameters by lazy {
        try {
            val ssm: AWSSimpleSystemsManagement = AWSSimpleSystemsManagementClientBuilder.defaultClient()
            ssm.getParameters(
                GetParametersRequest()
                    .withNames(
                        CrowdprojConstants.parameterCorsOrigins,
                        CrowdprojConstants.parameterCorsHeaders,
                        CrowdprojConstants.parameterCorsMethods
                    )
            )
                .parameters
        } catch (e: Throwable) {
            SdkInternalList<Parameter>()
        }
    }
    protected val corsOrigins by lazy {
        getParamStringList(CrowdprojConstants.parameterCorsOrigins)
    }
    protected val corsHeaders: String by lazy {
        getParamStringList(CrowdprojConstants.parameterCorsHeaders)
            .joinToString(",")
    }
    protected val corsMethods: String by lazy {
        getParamStringList(CrowdprojConstants.parameterCorsMethods)
            .joinToString(",")
    }

    override fun handleRequest(
        inputStream: InputStream,
        outputStream: OutputStream,
        context: Context
    ) {
        val logger = context.logger
        logger.log("CROWDPROJ GOT REQIEST")
        val localContext = createContext()
            .apply {
                timeStart = Instant.now()
                this.logger = AwsLogger(logger)
            }
        val objectMapper = ObjectMapper()
            .registerKotlinModule()
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)

        runBlocking {
            val obj = try {
                val json = inputStream.bufferedReader().use { it.readText() }
                logger.log("LAMBDA GOT $json")
//                localContext.request = objectMapper.readValue<T>(inputStream, requestClass) ?: throw EmptyDataException()
                val receivedRecord = objectMapper.readTree(json) ?: throw EmptyDataException()
                val body = receivedRecord["body"]?.asText() ?: ""
                with(localContext) {
                    requestData = receivedRecord
                    request = objectMapper.readValue(body, requestClass) ?: throw EmptyDataException()
                }
                logger.log("CRPWDPROJ GOT QUERY: ${localContext.request}")
                handlePost(localContext)
            } catch (e: EmptyDataException) {
                logger.log(e.toString())
                localContext.exception = e
                handleError(localContext)
            } catch (e: Exception) {
                logger.log(e.toString())
                localContext.exception = e
                handleError(localContext)
            }
        }

        val headers = localContext.requestData["headers"]
        val origin = headers?.get("Origin")?.asText("") ?: headers?.get("origin")?.asText("")
        val allowOrigin = origin.takeIf {
            corsOrigins.contains(it) || corsOrigins.contains("$it/")
        } ?: ""
        logger.log("Headers: $headers, Origin: $origin, Origins: $corsOrigins, AllowOrigin: $allowOrigin")
        val responseObject = AwsResponse(
            statusCode = 200,
            headers = mutableMapOf(
                "Content-Type" to "application/json",
                "X-Custom-Header" to "application/json",
                "Access-Control-Allow-Origin" to allowOrigin,
                "Access-Control-Allow-Headers" to corsHeaders,
                "Access-Control-Allow-Methods" to corsMethods
            ),
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

    fun getParamStringList(name: String): List<String> = parameters
        .find { it.name == name }
        ?.value
        ?.split(",")
        ?: emptyList()
}
