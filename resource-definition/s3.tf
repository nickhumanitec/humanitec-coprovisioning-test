resource "humanitec_resource_definition" "s3" {
  driver_type = "${var.humanitec_organization}/terraform"
  id          = "${local.app}-s3"
  name        = "${local.app}-s3"
  type        = "s3"

  provision = {
    "aws-policy#${local.app}-s3policy" = {
      "is_dependent" : true,
      "match_dependents" : true
    }
    # "aws-policy" = {
    #   "is_dependent" : true,
    #   "match_dependents" : true
    # }
  }

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
          path = "terraform/s3/"
          rev  = "refs/heads/aws"
          url  = "https://github.com/nickhumanitec/humanitec-coprovisioning-test.git"
        }
      )
      "variables" = jsonencode(
        {
          region   = var.region
          app      = "$${context.app.id}"
          env      = "$${context.env.id}"
          res      = "$${context.res.id}"
          app_name = local.app
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



resource "humanitec_resource_definition_criteria" "s3" {
  resource_definition_id = humanitec_resource_definition.s3.id
  app_id                 = humanitec_application.app.id
}
