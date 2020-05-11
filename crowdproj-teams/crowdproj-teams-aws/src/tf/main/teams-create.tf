resource "aws_lambda_permission" "teams_create" {
  statement_id = "v001-teams-teams-create"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.merged_0.arn}"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.back_crowdproj_app.id}/*/POST/teams/create"
}

resource "aws_api_gateway_resource" "teams_create" {
  depends_on = ["aws_api_gateway_resource.teams"]
  rest_api_id = "${aws_api_gateway_rest_api.back_crowdproj_app.id}"
  parent_id = "${aws_api_gateway_resource.teams.id}"
  path_part = "create"
}

resource "aws_api_gateway_method" "teams_create" {
  depends_on = ["aws_api_gateway_resource.teams_create"]
  rest_api_id = "${aws_api_gateway_rest_api.back_crowdproj_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_create.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "teams_create" {
  depends_on = ["aws_api_gateway_resource.teams_create"]
  rest_api_id = "${aws_api_gateway_rest_api.back_crowdproj_app.id}"
  resource_id = "${aws_api_gateway_resource.teams_create.id}"
  http_method = "POST"
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.merged_0.arn}/invocations"
}

