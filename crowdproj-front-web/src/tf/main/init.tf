variable "sourcePath" {
  default = ""
}
variable "bucketPublic" {
  default = ""
}
variable "bucketState" {
  default = ""
}
variable "region" {
  default = ""
}
variable "domain" {
  type        = string
  description = "The domain where to host the site. This must be the naked domain, e.g. `example.com`"
}
variable "domainZone" {
  default = ""
}
variable "enable_health_check" {
  type        = string
  default     = false
  description = "If true, it creates a Route53 health check that monitors the www endpoint and an alarm that triggers whenever it's not reachable. Please note this comes at an extra monthly cost on your AWS account"
}

//variable "health_check_alarm_sns_topics" {
//  type        = list(string)
//  default     = []
//  description = "A list of SNS topics to notify whenever the health check fails or comes back to normal"
//}

variable "enable_gzip" {
  type        = string
  default     = true
  description = "Whether to make CloudFront automatically compress content for web requests that include `Accept-Encoding: gzip` in the request header"
}

//terraform {
//  backend "s3" {
//  }
//}
//
//data "terraform_remote_state" "aws_tf_remote_state" {
//  backend = "s3"
//  config = {
//    bucket = var.bucketState
//    key    = "statuses/status-v001-public.tfstate"
//    region = var.region
//    encrypt = true
////    dynamodb_table = var.stateTable
//  }
//}

provider "aws" {
  region = var.region
  profile = "default"
  version = "~> 2.7"
}


//resource "aws_s3_bucket" "b" {
//  bucket = "com.crowdproj"
//  acl    = "public-read"
//  policy = "${file("policy.json")}"
//
//  website {
//    index_document = "index.html"
//    error_document = "error.html"
//
////    routing_rules = <<EOF
////[{
////    "Condition": {
////        "KeyPrefixEquals": "docs/"
////    },
////    "Redirect": {
////        "ReplaceKeyPrefixWith": "documents/"
////    }
////}]
////EOF
//  }
//}

resource "aws_s3_bucket" "state" {
  bucket = var.bucketState
}
resource "aws_s3_bucket" "main" {
  bucket = var.bucketPublic
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucketPublic}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
//  cors_rule {
//    allowed_headers = ["*"]
//    allowed_methods = ["PUT", "POST"]
//    allowed_origins = ["https://s3-website-test.hashicorp.com"]
//    expose_headers  = ["ETag"]
//    max_age_seconds = 3000
//  }
}

//resource "aws_s3_bucket" "redirect" {
//  bucket = "${var.bucketPublic}_1"
//
//  website {
//    redirect_all_requests_to = aws_s3_bucket.main.id
//  }
//}

resource "aws_s3_bucket_object" "dist" {
  for_each = fileset(var.sourcePath, "**/*.*")

  bucket = aws_s3_bucket.main.id
  key    = each.value
  source = "${var.sourcePath}/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("${var.sourcePath}/${each.value}")
}

locals {
  www_domain = var.domain

  domains = [
    var.domain,
//    var.domainZone,
  ]

  website_endpoints = [
//    aws_s3_bucket.redirect.website_endpoint,
    aws_s3_bucket.main.website_endpoint,
  ]
}
output "website_endpoint" {
  value = aws_s3_bucket.main.website_endpoint
}
output "website_domain" {
  value = aws_s3_bucket.main.website_domain
}
output "local_domains" {
  value = local.domains
}
output "local_www_domain" {
  value = local.www_domain
}

data "aws_route53_zone" "zone" {
  name = var.domainZone
}

data "aws_acm_certificate" "ssl" {
  provider = aws
  domain   = var.domainZone

  statuses = ["ISSUED"]
}

resource "aws_route53_record" "A" {
  count   = length(local.domains)
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = element(local.domains, count.index)
  type    = "A"

  alias {
    name                   = element(aws_cloudfront_distribution.cdn.*.domain_name, count.index)
    zone_id                = element(aws_cloudfront_distribution.cdn.*.hosted_zone_id, count.index)
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "AAAA" {
  count   = length(local.domains)
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = element(local.domains, count.index)
  type    = "AAAA"

  alias {
    name                   = element(aws_cloudfront_distribution.cdn.*.domain_name, count.index)
    zone_id                = element(aws_cloudfront_distribution.cdn.*.hosted_zone_id, count.index)
    evaluate_target_health = false
  }
}

resource "aws_cloudfront_distribution" "cdn" {
  count               = length(local.domains)
  enabled             = true
  default_root_object = element(local.domains, count.index) == local.www_domain ? "index.html" : ""
  aliases             = [element(local.domains, count.index)]
  is_ipv6_enabled     = true

  origin {
    domain_name = element(local.website_endpoints, count.index)
    origin_id   = "S3-${element(local.domains, count.index)}"

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = element(data.aws_acm_certificate.ssl.*.arn, count.index)
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${element(local.domains, count.index)}"
    compress         = var.enable_gzip

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }
}

//resource "aws_route53_health_check" "health_check" {
//  depends_on        = [aws_route53_record.A]
//  count             = var.enable_health_check ? 1 : 0
//  fqdn              = local.www_domain
//  port              = 80
//  type              = "HTTP"
//  resource_path     = "/"
//  failure_threshold = "3"
//  request_interval  = "30"
//
//  tags = {
//    Name = local.www_domain
//  }
//}

//resource "aws_cloudwatch_metric_alarm" "health_check_alarm" {
////  provider            = "aws.us-east-1"
//  count               = var.enable_health_check ? 1 : 0
//  alarm_name          = "${local.www_domain}-health-check"
//  comparison_operator = "LessThanThreshold"
//  evaluation_periods  = "1"
//  metric_name         = "HealthCheckStatus"
//  namespace           = "AWS/Route53"
//  period              = "60"
//  statistic           = "Minimum"
//  threshold           = "1.0"
//  alarm_description   = "This metric monitors the health of the endpoint"
//  ok_actions          = var.health_check_alarm_sns_topics
//  alarm_actions       = var.health_check_alarm_sns_topics
//  treat_missing_data  = "breaching"
//
//  dimensions = {
//    HealthCheckId = aws_route53_health_check.health_check[0].id
//  }
//}
