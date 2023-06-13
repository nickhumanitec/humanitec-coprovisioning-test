resource "humanitec_resource_definition" "s3policy" {
  driver_type = "${var.humanitec_organization}/terraform"
  id          = "${local.app}-s3policy"
  name        = "${local.app}-s3policy"
  type        = "aws-policy"

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
          path = "terraform/s3policy/"
          rev  = "refs/heads/aws"
          url  = "https://github.com/nickhumanitec/humanitec-coprovisioning-test.git"
        }
      )
      "variables" = jsonencode(
        {
          region   = var.region
          buckets  = "$${resources['aws-policy>s3'].outputs.bucket}"
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

resource "humanitec_resource_definition_criteria" "s3policy" {
  resource_definition_id = humanitec_resource_definition.s3policy.id
  app_id                 = humanitec_application.app.id
  res_id                 = "${local.app}-s3policy"
}
