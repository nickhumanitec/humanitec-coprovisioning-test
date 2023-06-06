variable "buckets" {
}

output "arn" {
  value = "arn:aws:iam::123456789012:policy/s3-${lower(random_string.random.result)}"
}
