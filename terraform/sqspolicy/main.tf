variable "url" {
}

output "arn" {
  value = "xxx"
  # value = "arn:aws:iam::123456789012:policy/${reverse(split("/", var.url))[0]}"
}
