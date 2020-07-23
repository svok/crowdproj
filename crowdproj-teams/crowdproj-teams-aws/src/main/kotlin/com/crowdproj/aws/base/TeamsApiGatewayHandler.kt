package com.crowdproj.aws.base

import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagementClientBuilder
import com.amazonaws.services.simplesystemsmanagement.model.GetParameterRequest
import com.amazonaws.services.simplesystemsmanagement.model.GetParametersRequest
import com.crowdproj.aws.CrowdprojConstants
import com.crowdproj.aws.handlers.*
import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.aws.*
import com.crowdproj.common.aws.exceptions.AwsParameterNotSet
import com.crowdproj.common.aws.exceptions.NoSuchResourceException
import com.crowdproj.common.aws.models.HandlerConfig
import com.crowdproj.rest.teams.models.RestQueryTeamFind
import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.rest.teams.models.RestQueryTeamSave
import com.crowdproj.teams.storage.common.ITeamStorage
import com.crowdproj.teams.storage.neptunedb.NeptuneDbTeamsStorage
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.json.JsonMapper
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.runBlocking
import org.slf4j.LoggerFactory
import kotlin.system.measureTimeMillis
import kotlin.time.ExperimentalTime
import kotlin.time.measureTimedValue

class TeamsApiGatewayHandler : AwsApiGatewayHandler() {
    private val jsonMapper = JsonMapper()
        .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
    private val logger = LoggerFactory.getLogger(this.javaClass)!!

    @OptIn(ExperimentalTime::class)
    private val parameters by lazy {
        try {
            val timedProperties = measureTimedValue {
                val ssm: AWSSimpleSystemsManagement = AWSSimpleSystemsManagementClientBuilder.defaultClient()
//                val paramsMap: Map<String, String> = runBlocking {
//                    listOf(
//                        CrowdprojConstants.parameterCorsOrigins,
//                        CrowdprojConstants.parameterCorsHeaders,
//                        CrowdprojConstants.parameterCorsMethods,
//                        CrowdprojConstants.parameterNeptuneEndpoint,
//                        CrowdprojConstants.parameterNeptunePort
//                    )
//                        .map {
//                            async {
//                                ssm.getParameter(
//                                    GetParameterRequest()
//                                        .withName(it)
//                                ).parameter
//                            }
//                        }
//                        .toList()
//                        .awaitAll()
//                        .map {
//                            it.name to it.value
//                        }
//                        .toMap()
//
//                }
//                paramsMap
                ssm.getParameters(
                    GetParametersRequest()
                        .withNames(
                            CrowdprojConstants.parameterCorsOrigins,
                            CrowdprojConstants.parameterCorsHeaders,
                            CrowdprojConstants.parameterCorsMethods,
                            CrowdprojConstants.parameterNeptuneEndpoint,
                            CrowdprojConstants.parameterNeptunePort
                        )
                )
                    .parameters
                    .map {
                        it.name to it.value
                    }
                    .toMap()
            }
            logger.info("REQUEST to SSM has taken ${timedProperties.duration}")
            timedProperties.value
        } catch (e: Throwable) {
            logger.error("Error getting SSM parameters: {}", e)
            throw e
//            emptyMap<String,String>()
        }
    }
    override val corsOrigins: List<String> by lazy {
        getParamStringList(CrowdprojConstants.parameterCorsOrigins)
    }
    override val corsHeaders: List<String> by lazy {
        getParamStringList(CrowdprojConstants.parameterCorsHeaders)
    }
    override val corsMethods: List<String> by lazy {
        getParamStringList(CrowdprojConstants.parameterCorsMethods)
    }

    private val neptuneEndpoint: String by lazy {
        val param = CrowdprojConstants.parameterNeptuneEndpoint
        getParamString(param)
            ?: throw AwsParameterNotSet(param, parameters)
    }
    private val neptunePort: Int by lazy {
        val param = CrowdprojConstants.parameterNeptunePort
        getParamString(param)
            ?.toIntOrNull()
            ?: 8182
    }

    private val storage: ITeamStorage by lazy {
        NeptuneDbTeamsStorage(
            endpoint = neptuneEndpoint,
            port = neptunePort
        )
    }
//    private val storage: ITeamStorage by lazy {
//        DynamoDbTeamsStorage(
//            tableName = "crowdproj-teams-table"
//        )
//    }


    override fun initHandler(body: HandlerConfig.() -> Unit): IAwsHandlerConfig {
        val config: HandlerConfig = HandlerConfig()
            .apply(body)
        return when (config.resource) {
            // GET
            TeamsGetHandler.requestResource -> TeamsHandlerConfig(
                handler = TeamsGetHandler(),
                contextCreator = {
                    prepareContext(
                        TeamsGetRequestContext(
                            timeStart = config.timeStart,
                            logger = config.logger,
                            requestInput = config.requestInput,
                            requestContext = config.requestContext,
                            requestBody = config.requestBody,
                            responseHeaders = config.responseHeaders,
                            dbTeamsStorage = storage

                        ),
                        config = config,
                        requestClass = RestQueryTeamGet::class.java
                    )
                },
                prepareResult = { prepareResult(it as TeamsGetRequestContext) }
            )
            // INDEX
            TeamsIndexHandler.requestResource -> TeamsHandlerConfig(
                handler = TeamsIndexHandler(),
                contextCreator = {
                    prepareContext(
                        context = TeamsIndexRequestContext(
                            timeStart = config.timeStart,
                            logger = config.logger,
                            requestInput = config.requestInput,
                            requestContext = config.requestContext,
                            requestBody = config.requestBody,
                            responseHeaders = config.responseHeaders,
                            dbTeamsStorage = storage
                        ),
                        config = config,
                        requestClass = RestQueryTeamFind::class.java
                    )
                },
                prepareResult = { prepareResult(it as TeamsIndexRequestContext) }
            )

            // CREATE
            TeamsCreateHandler.requestResource -> TeamsHandlerConfig(
                handler = TeamsCreateHandler(),
                contextCreator = {
                    prepareContext(
                        TeamsSaveRequestContext(
                            timeStart = config.timeStart,
                            logger = config.logger,
                            requestInput = config.requestInput,
                            requestContext = config.requestContext,
                            requestBody = config.requestBody,
                            responseHeaders = config.responseHeaders,
                            dbTeamsStorage = storage
                        ),
                        config = config,
                        requestClass = RestQueryTeamSave::class.java
                    )
                },
                prepareResult = { prepareResult(it as TeamsSaveRequestContext) }
            )

            // UPDATE
            TeamsUpdateHandler.requestResource -> TeamsHandlerConfig(
                handler = TeamsUpdateHandler(),
                contextCreator = {
                    prepareContext(
                        TeamsSaveRequestContext(
                            timeStart = config.timeStart,
                            logger = config.logger,
                            requestInput = config.requestInput,
                            requestContext = config.requestContext,
                            requestBody = config.requestBody,
                            responseHeaders = config.responseHeaders,
                            dbTeamsStorage = storage
                        ),
                        config = config,
                        requestClass = RestQueryTeamSave::class.java
                    )
                },
                prepareResult = { prepareResult(it as TeamsSaveRequestContext) }
            )
            else -> throw NoSuchResourceException(config.resource)
        }
    }

    data class TeamsHandlerConfig(
        override val handler: IAwsHandler,
        override val contextCreator: () -> IRequestContext,
        override val prepareResult: (context: IRequestContext) -> Unit
    ) : IAwsHandlerConfig

    private fun <Rq, Rs, T : RequestContext<Rq, Rs>> prepareContext(
        context: T,
        config: HandlerConfig,
        requestClass: Class<Rq>
    ): T {
        context.apply {
            timeStart = config.timeStart
            logger = config.logger
            requestInput = config.requestInput
            requestContext = config.requestContext
            requestBody = config.requestBody
            responseHeaders = config.responseHeaders
            responseCode = 200
            responseEncoded = false
        }
        try {
            context.logger.debug("Parsing class $requestClass with json ${config.requestBody}")
            val parsedRequest: Rq = jsonMapper.readValue(config.requestBody, requestClass)
            context.request = parsedRequest
            context.logger.info("JSON: ${config.requestBody} -> $parsedRequest")
        } catch (e: Throwable) {
            context.logger.error("Error parsing request body: $e")
            context.errors.add(e.toError("BAD_REQUEST"))
            context.status = ContextStatuses.failing
        }
        return context
    }

    private fun <Rq, Rs, T : RequestContext<Rq, Rs>> prepareResult(context: T) {
        context.responseBody = jsonMapper.writeValueAsString(context.response)
    }

    private fun getParamString(name: String): String? = parameters[name]

    private fun getParamStringList(name: String): List<String> = getParamString(name)
        ?.split(",")
        ?: emptyList()

}
