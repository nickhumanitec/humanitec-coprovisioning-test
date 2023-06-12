resource "random_string" "random" {
  length  = 16
  special = false
}

output "aws_secret_access_key" {
  value = ""
}

output "aws_access_key_id" {
  value = ""
}

resource "aws_s3_bucket" "b" {
}

output "region" {
  value = var.region
}

output "bucket" {
  value = aws_s3_bucket.b.arn
}
