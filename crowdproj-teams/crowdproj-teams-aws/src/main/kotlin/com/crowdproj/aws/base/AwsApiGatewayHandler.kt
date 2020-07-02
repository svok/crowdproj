package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestHandler
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent
import com.crowdproj.common.Error
import kotlinx.coroutines.runBlocking
import java.time.Instant


abstract class AwsApiGatewayHandler() : RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    protected abstract val corsOrigins: List<String>
    protected abstract val corsHeaders: List<String>
    protected abstract val corsMethods: List<String>

    override fun handleRequest(input: APIGatewayProxyRequestEvent, context: Context): APIGatewayProxyResponseEvent {
        val logger = context.logger
        logger.log("AWS GOT REQUEST: $input")
//        val objectMapper = ObjectMapper()
//            .registerKotlinModule()
//            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)

        val rqHeaders = input.headers ?: emptyMap()
        val origin = rqHeaders["Origin"] ?: rqHeaders["origin"]
        val allowOrigin = origin.takeIf {
            corsOrigins.contains(it) || corsOrigins.contains("$it/")
        } ?: ""
        logger.log("Headers: $rqHeaders, Origin: $origin, Origins: $corsOrigins, AllowOrigin: $allowOrigin")
        val rsHeaders = mutableMapOf(
            "Content-Type" to "application/json",
            "X-Custom-Header" to "application/json",
            "Access-Control-Allow-Origin" to allowOrigin,
            "Access-Control-Allow-Headers" to corsHeaders.joinToString(","),
            "Access-Control-Allow-Methods" to corsMethods.joinToString(",")
        )

        val apiGatewayHandler: IAwsHandlerConfig = initHandler {
            timeStart = Instant.now()!!
            resource = input.resource ?: ""
            requestInput = input
            requestContext = context
            requestBody = input.body
            this.logger = AwsLogger(logger)

            responseHeaders = rsHeaders
        }

        val localContext: IRequestContext = try {
            val localContext = apiGatewayHandler.contextCreator()
            runBlocking { apiGatewayHandler.handler.exec(localContext) }
            logger.log("Done with localContext: $localContext")
            apiGatewayHandler.prepareResult(localContext)
            localContext
        } catch (e: NoSuchResourceException) {
            logger.log("CAUGHT exception: $e")
            EmptyRequestContext(
                errors = mutableListOf(e.toError()),
                responseCode = 404,
                responseHeaders = rsHeaders
            )
        } catch (e: Throwable) {
            logger.log("CAUGHT exception: $e")
            EmptyRequestContext(
                errors = mutableListOf(e.toError()),
                responseHeaders = rsHeaders,
                responseCode = 500
            )
        }

        logger.log("All done preparing response")
        return APIGatewayProxyResponseEvent()
            .withBody(localContext.responseBody)
            .withHeaders(localContext.responseHeaders)
            .withIsBase64Encoded(localContext.responseEncoded)
            .withStatusCode(localContext.responseCode)
    }

    abstract fun initHandler(body: HandlerConfig.() -> Unit): IAwsHandlerConfig
}

fun Throwable.toError(id: String? = null): Error = Error(
    id = id ?: "UNEXPECTED",
    title = this.message ?: ""
)

private fun NoSuchResourceException.toError(): Error = Error(
    id = "NOT_FOUND",
    title = this.message ?: ""
)
