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

resource "aws_iam_policy" "policy" {
  policy = data.aws_iam_policy_document.policy.json
}

output "arn" {
  value = aws_iam_policy.policy.arn
}
