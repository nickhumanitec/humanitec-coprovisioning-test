resource "random_string" "random" {
  length  = 16
  special = false
}

variable "policy_arns" {
  type    = set(string)
  default = []
}
output "arn" {
  value = "arn:aws:iam::123456789012:role/${lower(random_string.random.result)}"
}
