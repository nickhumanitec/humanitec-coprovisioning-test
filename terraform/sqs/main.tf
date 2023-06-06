resource "random_string" "random" {
  length  = 16
  special = false
}

output "region" {
  value = "ca-central-1"
}
output "arn" {
  value = "arn:aws:sqs:ca-central-1:123456789012:${lower(random_string.random.result)}"
}

output "url" {
  value = "https://sqs.ca-central-1.amazonaws.com/123456789012/${lower(random_string.random.result)}"
}
