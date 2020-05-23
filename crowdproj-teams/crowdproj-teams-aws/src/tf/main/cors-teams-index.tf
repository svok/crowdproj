resource "aws_api_gateway_method" "cors_teams_index" {
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  resource_id = aws_api_gateway_resource.teams_index.id
  http_method   = "OPTIONS"
  authorization = "NONE"
//  api_key_required = true
}

resource "aws_api_gateway_integration" "cors_teams_index" {
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  resource_id = aws_api_gateway_resource.teams_index.id
  http_method = aws_api_gateway_method.cors_teams_index.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

resource "aws_api_gateway_integration_response" "cors_teams_index" {
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  resource_id = aws_api_gateway_resource.teams_index.id
  http_method = aws_api_gateway_method.cors_teams_index.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'${join(",", var.corsOrigins)}'",
    "method.response.header.Access-Control-Allow-Headers" = "'${join(",", var.corsHeaders)}'",
    "method.response.header.Access-Control-Allow-Methods" = "'${join(",", var.corsMethods)}'",
  }
  depends_on = [
    aws_api_gateway_integration.cors_teams_index,
    aws_api_gateway_method_response.cors_teams_index
  ]
}

resource "aws_api_gateway_method_response" "cors_teams_index" {
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  resource_id = aws_api_gateway_resource.teams_index.id
  http_method = aws_api_gateway_method.cors_teams_index.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_integration.cors_teams_index,
    aws_api_gateway_method.cors_teams_index
  ]
}

//module "cors" {
//  source = "squidfunk/api-gateway-enable-cors/aws"
//  version = "0.3.1"
//
//  api_id          = aws_api_gateway_rest_api.back_crowdproj_app.id
//  api_resource_id = aws_api_gateway_resource.teams_index.id
//}
