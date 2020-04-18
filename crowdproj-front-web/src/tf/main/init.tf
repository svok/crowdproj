variable "sourcePath" {
  default = ""
}
resource "aws_s3_bucket_object" "dist" {
  for_each = fileset(var.sourcePath, "*")

  bucket = "test-terraform-pawan-1"
  key    = each.value
  source = "${var.sourcePath}${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("${var.sourcePath}${each.value}")
}

resource "aws_s3_bucket" "b" {
  bucket = "com.crowdproj"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"

//    routing_rules = <<EOF
//[{
//    "Condition": {
//        "KeyPrefixEquals": "docs/"
//    },
//    "Redirect": {
//        "ReplaceKeyPrefixWith": "documents/"
//    }
//}]
//EOF
  }
}
