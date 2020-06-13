terraform {
  backend "s3" {
  }
}
provider "aws" {
  region = var.region
  profile = "default"
  version = "~> 2.7"
}
data "aws_s3_bucket" "main" {
  bucket = var.bucketPublic
}
resource "aws_s3_bucket_object" "dist" {
  for_each = fileset(var.sourcePath, "**/*.*")

  bucket = data.aws_s3_bucket.main.id
  key    = "${var.baseName}${each.value}"
  source = "${var.sourcePath}/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("${var.sourcePath}/${each.value}")
  acl = "public-read"
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
