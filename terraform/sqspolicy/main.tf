variable "urls" {
}
variable "arns" {

}

resource "random_string" "random" {
  length  = 16
  special = false
}

output "arn" {

  value = "arn:aws:iam::123456789012:policy/sqs-${lower(random_string.random.result)}"
  # value = "arn:aws:iam::123456789012:policy/${reverse(split("/", var.url))[0]}"
}
