resource "random_string" "random" {
  length  = 16
  special = false
}

output "region" {
  value = var.region
}

variable "app_name" {}
resource "aws_sqs_queue" "q" {
  name_prefix = var.app_name
}

output "arn" {
  value = aws_sqs_queue.q.arn
}

output "url" {
  value = aws_sqs_queue.q.url
}
