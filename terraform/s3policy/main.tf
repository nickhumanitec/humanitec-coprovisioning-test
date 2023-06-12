variable "buckets" {
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = var.buckets

  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = var.buckets
  }
}

resource "aws_iam_policy" "policy" {
  policy = data.aws_iam_policy_document.policy.json
}

output "arn" {
  value = aws_iam_policy.policy.arn
}

