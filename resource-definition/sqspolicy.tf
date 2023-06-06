resource "humanitec_resource_definition" "sqspolicy" {
  driver_type = "${var.humanitec_organization}/terraform"
  id          = "${local.app}-sqspolicy"
  name        = "${local.app}-sqspolicy"
  type        = "aws-policy"

  driver_inputs = {
    secrets = {
      variables = jsonencode({

      })
    },
    values = {
      "source" = jsonencode(
        {
          path = "terraform/sqspolicy/"
          rev  = "refs/heads/main"
          url  = "https://github.com/nickhumanitec/humanitec-coprovisioning-test.git"
        }
      )
      "variables" = jsonencode(
        {
          # url = "$${resources['sqs#${local.app}-sqs'].outputs.url}"
          url = "$${resources['aws-policy>postgres'].outputs.url}"
          app = "$${context.app.id}"
          env = "$${context.env.id}"
          res = "$${context.res.id}"
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

resource "humanitec_resource_definition_criteria" "sqspolicy" {
  resource_definition_id = humanitec_resource_definition.sqspolicy.id
  app_id                 = humanitec_application.app.id
  res_id                 = "${local.app}-sqspolicy"
}
