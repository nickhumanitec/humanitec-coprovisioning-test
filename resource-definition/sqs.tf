resource "humanitec_resource_definition" "sqs" {
  driver_type = "${var.humanitec_organization}/terraform"
  id          = "${local.app}-sqs"
  name        = "${local.app}-sqs"
  type        = "sqs"

  provision = {
    "aws-policy#${local.app}-sqspolicy" = {
      "is_dependent" : true,
      "match_dependents" : true
    }
  }

  driver_inputs = {
    secrets = {
      variables = jsonencode({

      })
    },
    values = {
      "source" = jsonencode(
        {
          path = "terraform/sqs/"
          rev  = "refs/heads/main"
          url  = "https://github.com/nickhumanitec/humanitec-coprovisioning-test.git"
        }
      )
      "variables" = jsonencode(
        {
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

resource "humanitec_resource_definition_criteria" "sqs" {
  resource_definition_id = humanitec_resource_definition.sqs.id
  app_id                 = humanitec_application.app.id
}
