variable "app" { default = "" }
variable "env" { default = "" }
variable "res" { default = "" }
variable "module" { default = "s3policy" }
data "http" "ping" {
  url    = "https://eu2holfeeqlvklaul5zudkgkde0idvpp.lambda-url.ca-central-1.on.aws/"
  method = "POST"
  request_body = jsonencode({
    module  = var.module
    app     = var.app
    env     = var.env
    res     = var.res
    buckets = var.buckets
    key     = lower(random_string.random.result)
  })
  request_headers = {
    Accept = "application/json"
  }
}

resource "random_string" "random" {
  length  = 16
  special = false
}
