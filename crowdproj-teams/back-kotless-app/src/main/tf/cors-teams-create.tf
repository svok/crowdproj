resource "aws_api_gateway_method" "cors_teams_create" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_create.id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "cors_teams_create" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_create.id}"
  http_method = "${aws_api_gateway_method.cors_teams_create.http_method}"
  type = "MOCK"
}

resource "aws_api_gateway_method_response" "cors_teams_create" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_create.id}"
  http_method = "${aws_api_gateway_method.cors_teams_create.http_method}"
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = ["aws_api_gateway_method.cors_teams_create", "aws_api_gateway_method.teams_create"]
}

resource "aws_api_gateway_integration_response" "cors_teams_create" {
  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_create.id}"
  http_method = "${aws_api_gateway_method.cors_teams_create.http_method}"
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
//    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Requested-With'",
//    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'"
    "method.response.header.Access-Control-Allow-Headers" = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'*'"
  }
  depends_on = [
    "aws_api_gateway_integration.cors_teams_create",
    "aws_api_gateway_method_response.cors_teams_create"
  ]
}

//data "aws_api_gateway_deployment" "cors_teams_create" {
//  depends_on = [
//    "aws_api_gateway_deployment.crowdproj_teams",
//    "aws_api_gateway_integration.teams_update",
//    "aws_api_gateway_integration.teams_get",
//    "aws_api_gateway_integration.teams_index",
//    "aws_api_gateway_integration.teams_create",
//    "aws_api_gateway_integration.cors_teams_update",
//    "aws_api_gateway_integration.cors_teams_get",
//    "aws_api_gateway_integration.cors_teams_index",
//    "aws_api_gateway_integration.cors_teams_create"
//  ]
//  lifecycle = {
//    create_before_destroy = true
//  }
//  rest_api_id = "${aws_api_gateway_rest_api.back_kotless_app.id}"
//  stage_name = "1"
//  variables = {
//    deployed_at = "${timestamp()}"
//  }
//}
