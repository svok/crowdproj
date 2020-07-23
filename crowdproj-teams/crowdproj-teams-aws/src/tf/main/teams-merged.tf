resource "aws_lambda_permission" "teams_merged" {
  statement_id = "v001-teams-teams-merged"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.teams_merged.arn
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.back_app.id}/*/POST/teams/*"
}

resource "aws_lambda_function" "teams_merged" {
  function_name = "v001-teams-merged-post"
  role = aws_iam_role.teams_merged.arn
  s3_bucket = var.bucketBackend
  s3_key = aws_s3_bucket_object.merged_0.key
  source_code_hash = base64sha256(filebase64sha512(aws_s3_bucket_object.merged_0.source))
  handler = var.handler
//  runtime = "java8"
  runtime = "java11"
  timeout = 300
//  memory_size = 1024
  memory_size = 512
  environment {
    variables = {
      KOTLESS_PACKAGES = "com.crowdproj"
    }
  }
  vpc_config {
    security_group_ids = [aws_default_security_group.main_vpc.id]
    subnet_ids = aws_subnet.nat.*.id
  }
}

resource "aws_iam_role" "teams_merged" {
  name = "v001-teams-merged-post"
  assume_role_policy = data.aws_iam_policy_document.merged_0_assume.json
}

resource "aws_iam_role_policy" "teams_merged" {
  role = aws_iam_role.teams_merged.name
  policy = data.aws_iam_policy_document.crowdproj_teams_table.json
}

resource "aws_cloudwatch_log_group" "teams_merged" {
  name              = "/aws/lambda/${aws_lambda_function.teams_merged.function_name}"
  retention_in_days = 14
}

resource "aws_iam_role_policy_attachment" "teams_merged" {
  role       = aws_iam_role.teams_merged.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "teams_merged_ssm" {
  role       = aws_iam_role.teams_merged.name
  policy_arn = aws_iam_policy.params_access.arn
}

resource "aws_iam_role_policy_attachment" "teams_merged_vpc_access" {
  role       = aws_iam_role.teams_merged.name
  policy_arn = aws_iam_policy.vpc_access.arn
}

resource "aws_iam_role_policy_attachment" "neptune" {
//  depends_on = [
//    aws_ssm_parameter.parameter-neptune-endpoint,
//    aws_ssm_parameter.parameter-neptune-port
//  ]
  role       = aws_iam_role.teams_merged.name
  policy_arn = "arn:aws:iam::aws:policy/NeptuneFullAccess"
}

