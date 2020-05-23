resource "aws_api_gateway_integration" "teams_index" {
  depends_on = ["aws_api_gateway_resource.teams_index"]
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  resource_id = aws_api_gateway_resource.teams_index.id
  http_method = "POST"
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.teams_index_post.arn}/invocations"
}

resource "aws_lambda_permission" "teams_index" {
  statement_id = "v001-teams-teams-index"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.teams_index_post.arn
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.back_app.id}/*/POST/teams/index"
}

resource "aws_api_gateway_resource" "teams_index" {
  depends_on = ["aws_api_gateway_resource.teams"]
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  parent_id = aws_api_gateway_resource.teams.id
  path_part = "index"
}

resource "aws_api_gateway_method" "teams_index" {
  depends_on = ["aws_api_gateway_resource.teams_index"]
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  resource_id = aws_api_gateway_resource.teams_index.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_lambda_function" "teams_index_post" {
  function_name = "v001-teams-index-post"
  role = aws_iam_role.teams_index_post.arn
  s3_bucket = var.bucketBackend
  s3_key = aws_s3_bucket_object.merged_0.key
  source_code_hash = base64sha256(filebase64sha512(aws_s3_bucket_object.merged_0.source))
  handler = var.handlers["teams-index"]
  runtime = "java8"
  timeout = 300
  memory_size = 1024
  environment {
    variables = {
      KOTLESS_PACKAGES = "com.crowdproj"
    }
  }
}

resource "aws_iam_role" "teams_index_post" {
  name = "v001-teams-index-post"
  assume_role_policy = data.aws_iam_policy_document.merged_0_assume.json
}

resource "aws_iam_role_policy" "crowdproj_teams_index_post" {
  role = aws_iam_role.teams_index_post.name
  policy = data.aws_iam_policy_document.crowdproj_teams_table.json
}

resource "aws_cloudwatch_log_group" "teams_index_post" {
  name              = "/aws/lambda/${aws_lambda_function.teams_index_post.function_name}"
  retention_in_days = 14
}

resource "aws_iam_role_policy_attachment" "teams_index_post" {
  role       = aws_iam_role.teams_index_post.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "teams_index_ssm" {
  role       = aws_iam_role.teams_index_post.name
  policy_arn = aws_iam_policy.params_access.arn
}
