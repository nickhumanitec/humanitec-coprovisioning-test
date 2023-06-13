resource "humanitec_resource_definition" "role" {
  driver_type = "${var.humanitec_organization}/terraform"
  id          = "${local.app}-role"
  name        = "${local.app}-role"
  type        = "aws-role"

  driver_inputs = {
    secrets = {
      variables = jsonencode({
        access_key = var.access_key
        secret_key = var.secret_key
      })
    },
    values = {
      "source" = jsonencode(
        {
          path = "terraform/role/"
          rev  = "refs/heads/aws"
          url  = "https://github.com/nickhumanitec/humanitec-coprovisioning-test.git"
        }
      )
      "variables" = jsonencode(
        {
          region       = var.region
          cluster_oidc = var.cluster_oidc
          policy_arns  = "$${resources.workload>aws-policy.outputs.arn}"
          app          = "$${context.app.id}"
          env          = "$${context.env.id}"
          res          = "$${context.res.id}"
          app_name     = local.app
        }
      )
    }
  }
  lifecycle {
    ignore_changes = [
      criteria
    ]
  }
}



resource "humanitec_resource_definition_criteria" "role" {
  resource_definition_id = humanitec_resource_definition.role.id
  app_id                 = humanitec_application.app.id
}
