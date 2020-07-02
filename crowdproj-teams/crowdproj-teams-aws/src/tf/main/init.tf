data "aws_caller_identity" "current" {
}

provider "aws" {
  region = var.region
  profile = "default"
  version = "~> 2.7"
}

resource "aws_api_gateway_rest_api" "back_app" {
  name = "v001-teams-back-crowdproj-app"
  binary_media_types = [
    "image/png",
    "image/apng",
    "image/gif",
    "image/jpeg",
    "image/bmp",
    "image/webp",
    "application/zip",
    "application/gzip",
    "font/ttf"
  ]
}

resource "aws_iam_role" "crowdproj_static_role" {
  name = "v001-teams-crowdproj-static-role"
  assume_role_policy = data.aws_iam_policy_document.crowdproj_static_assume.json
}

data "aws_iam_policy_document" "crowdproj_static_assume" {
  statement {
    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_api_gateway_resource" "teams" {
  depends_on = [aws_api_gateway_rest_api.back_app]
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  parent_id = aws_api_gateway_rest_api.back_app.root_resource_id
  path_part = "teams"
}

output "application_url" {
  value = "https://${var.domain}"
}

resource "aws_route53_record" "v001_teams_crowdproj_com" {
  zone_id = data.aws_route53_zone.crowdproj_com.zone_id
  name = element(split(",", var.domain), 0)
  type = "A"
  alias {
    name = aws_api_gateway_domain_name.back_crowdproj_app.cloudfront_domain_name
    zone_id = aws_api_gateway_domain_name.back_crowdproj_app.cloudfront_zone_id
    evaluate_target_health = false
  }
}

data "aws_iam_policy_document" "merged_0" {
  statement {
    effect = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    actions = ["logs:GetLogEvents", "logs:GetLogRecord", "logs:GetLogGroupFields", "logs:GetQueryResults", "logs:DescribeLogGroups", "logs:DescribeLogStreams", "logs:DescribeMetricFilters", "logs:CreateLogGroup", "logs:DeleteLogGroup", "logs:CreateLogStream", "logs:DeleteLogStream", "logs:PutLogEvents", "logs:DeleteMetricFilter", "logs:PutMetricFilter"]
  }
}

data "aws_iam_policy_document" "merged_0_assume" {
  statement {
    principals {
      identifiers = ["lambda.amazonaws.com", "apigateway.amazonaws.com"]
      type = "Service"
    }
    actions = ["sts:AssumeRole"]
  }

}

resource "aws_s3_bucket_object" "merged_0" {
  bucket = var.bucketBackend
  key = "${var.bucketJarName}.all.jar"
  source = var.handlerJar
  etag = filemd5(var.handlerJar)
}

data "aws_acm_certificate" "crowdproj_com" {
  domain = var.domainZone
  statuses = ["ISSUED"]
}

//resource "aws_iam_role" "merged_0" {
//  name = "v001-teams-merged-0"
//  assume_role_policy = data.aws_iam_policy_document.merged_0_assume.json
//}

terraform {
  backend "s3" {
  }
}

resource "aws_api_gateway_domain_name" "back_crowdproj_app" {
  domain_name = var.domain
  certificate_arn = data.aws_acm_certificate.crowdproj_com.arn
}

data "aws_region" "current" {

}

//resource "aws_iam_role_policy" "merged_0" {
//  role = aws_iam_role.merged_0.name
//  policy = data.aws_iam_policy_document.merged_0.json
//}

resource "aws_iam_role_policy" "crowdproj_static_policy" {
  role = aws_iam_role.crowdproj_static_role.name
  policy = data.aws_iam_policy_document.crowdproj_static_policy.json
}

resource "aws_api_gateway_deployment" "crowdproj_teams" {
  depends_on = [
    aws_api_gateway_integration.teams_create,
    aws_api_gateway_integration.cors_teams_create,
    aws_api_gateway_integration.teams_get,
    aws_api_gateway_integration.cors_teams_get,
    aws_api_gateway_integration.teams_index,
    aws_api_gateway_integration.cors_teams_index,
    aws_api_gateway_integration.teams_update,
    aws_api_gateway_integration.cors_teams_update
  ]
  lifecycle {
    create_before_destroy = true
  }
  rest_api_id = aws_api_gateway_rest_api.back_app.id
  stage_name = "1"
  variables = {
    deployed_at = timestamp()
  }
}

data "aws_iam_policy_document" "crowdproj_static_policy" {
  statement {
    effect = "Allow"
    resources = ["${aws_s3_bucket.crowdproj_bucket.arn}/*"]
    actions = ["s3:GetObject"]
  }
}

resource "aws_api_gateway_base_path_mapping" "back_crowdproj_app" {
  api_id = aws_api_gateway_rest_api.back_app.id
  stage_name = aws_api_gateway_deployment.crowdproj_teams.stage_name
  domain_name = var.domain
}

data "aws_route53_zone" "crowdproj_com" {
  name = var.domainZone
  private_zone = false
}

resource "aws_s3_bucket" "crowdproj_bucket" {
  bucket = var.bucketBackend
}

# Parameter store in SSM
resource "aws_ssm_parameter" "parameter-cors-origins" {
  name  = var.parameterCorsOrigins
  type  = "StringList"
  value = join(",", var.corsOrigins)
}
resource "aws_ssm_parameter" "parameter-cors-headers" {
  name  = var.parameterCorsHeaders
  type  = "StringList"
  value = join(",", var.corsHeaders)
}
resource "aws_ssm_parameter" "parameter-cors-methods" {
  name  = var.parameterCorsMethods
  type  = "StringList"
  value = join(",", var.corsMethods)
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.parametersPrefix}-lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "params_access" {
  name        = "${var.parametersPrefix}-params_access"
  path        = "/"
  description = "IAM policy for accessing SSM parameters"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "SSMFixinatorAPIKeyPolicy",
          "Effect": "Allow",
          "Action": [
            "ssm:GetParameters"
          ],
          "Resource": [
            "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.parametersPrefix}.*"
          ]
      }
  ]
}
EOF
}
