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

output "region" {
  value = "ca-central-1"
}

output "bucket" {
  value = "arn:aws:s3:::${lower(random_string.random.result)}"
}
