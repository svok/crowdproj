resource "aws_api_gateway_method" "cors_teams_get" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_get.id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "cors_teams_get" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_get.id}"
  http_method = "${aws_api_gateway_method.cors_teams_get.http_method}"
  type = "MOCK"
}

resource "aws_api_gateway_method_response" "cors_teams_get" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_get.id}"
  http_method = "${aws_api_gateway_method.cors_teams_get.http_method}"
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = ["aws_api_gateway_method.cors_teams_get", "aws_api_gateway_method.teams_get"]
}

resource "aws_api_gateway_integration_response" "cors_teams_get" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_get.id}"
  http_method = "${aws_api_gateway_method.cors_teams_get.http_method}"
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
//    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Requested-With'",
//    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'"
    "method.response.header.Access-Control-Allow-Headers" = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'*'"
  }
  depends_on = [
    "aws_api_gateway_integration.cors_teams_get",
    "aws_api_gateway_method_response.cors_teams_get"
  ]
}
