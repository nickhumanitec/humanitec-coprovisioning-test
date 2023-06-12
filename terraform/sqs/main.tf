resource "random_string" "random" {
  length  = 16
  special = false
}

output "region" {
  value = var.region
}
resource "aws_sqs_queue" "q" {
}

output "arn" {
  value = aws_sqs_queue.q.arn
}

output "url" {
  value = aws_sqs_queue.q.url
}
