resource "random_string" "random" {
  length  = 16
  special = false
}

variable "policy_arns" {
  type    = set(string)
  default = []
}
variable "app_name" {}
variable "cluster_oidc" {}
variable "namespace" { default = "*" }
variable "service_account" { default = "*" }

resource "aws_iam_role_policy_attachment" "policies" {
  for_each   = var.policy_arns
  role       = aws_iam_role.eks.name
  policy_arn = each.value
}

resource "aws_iam_role" "eks" {
  name_prefix = var.app_name
  // below uses StringLike to allow wildcards for multiple service accounts within the same namespace for workloads
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${var.cluster_oidc}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${var.cluster_oidc}:sub" : "system:serviceaccount:${var.namespace}:${var.service_account}",
            "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${var.cluster_oidc}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    }
  )

}

output "arn" {
  value = aws_iam_role.eks.arn
}
