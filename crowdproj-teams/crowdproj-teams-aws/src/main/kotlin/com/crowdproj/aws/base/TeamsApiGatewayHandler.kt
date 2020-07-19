package com.crowdproj.aws.base

import com.amazonaws.internal.SdkInternalList
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagementClientBuilder
import com.amazonaws.services.simplesystemsmanagement.model.GetParametersRequest
import com.amazonaws.services.simplesystemsmanagement.model.Parameter
import com.crowdproj.aws.CrowdprojConstants
import com.crowdproj.common.aws.exceptions.AwsParameterNotSet
import com.crowdproj.common.aws.exceptions.NoSuchResourceException
import com.crowdproj.aws.handlers.*
import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.aws.*
import com.crowdproj.common.aws.models.HandlerConfig
import com.crowdproj.rest.teams.models.RestQueryTeamFind
import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.rest.teams.models.RestQueryTeamSave
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.crowdproj.teams.storage.dynamodb.NeptuneDbTeamsStorage
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.json.JsonMapper

class TeamsApiGatewayHandler : AwsApiGatewayHandler() {
    private val jsonMapper = JsonMapper()
        .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)

    private val parameters by lazy {
        try {
            val ssm: AWSSimpleSystemsManagement = AWSSimpleSystemsManagementClientBuilder.defaultClient()
            ssm.getParameters(
                GetParametersRequest()
                    .withNames(
                        CrowdprojConstants.parameterCorsOrigins,
                        CrowdprojConstants.parameterCorsHeaders,
                        CrowdprojConstants.parameterCorsMethods,
                        CrowdprojConstants.parameterNeptuneEndpoint
                    )
            )
                .parameters
        } catch (e: Throwable) {
            SdkInternalList<Parameter>()
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

    val neptuneEndpoint: String? by lazy {
        getParamString(CrowdprojConstants.parameterNeptuneEndpoint)
    }

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
                            dbTeamsStorage = NeptuneDbTeamsStorage(
                                neptuneEndpoint = getParamString(CrowdprojConstants.parameterNeptuneEndpoint)
                                    ?: throw AwsParameterNotSet(
                                        CrowdprojConstants.parameterNeptuneEndpoint
                                    )
                            )
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
                            responseHeaders = config.responseHeaders
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
                            responseHeaders = config.responseHeaders
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
                            responseHeaders = config.responseHeaders
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

    private fun getParamString(name: String): String? = parameters
        .find { it.name == name }
        ?.value

    private fun getParamStringList(name: String): List<String> = getParamString(name)
        ?.split(",")
        ?: emptyList()

}
