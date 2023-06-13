variable "urls" {
}
variable "arns" {

}

resource "random_string" "random" {
  length  = 16
  special = false
}

data "aws_iam_policy_document" "policy" {

  statement {
    actions = [
      "sqs:*",
    ]

    resources = var.arns
  }
}

variable "app_name" {}
resource "aws_iam_policy" "policy" {
  name_prefix = var.app_name
  policy      = data.aws_iam_policy_document.policy.json
}

output "arn" {
  value = aws_iam_policy.policy.arn
}
