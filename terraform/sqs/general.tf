variable "app" { default = "" }
variable "env" { default = "" }
variable "res" { default = "" }
variable "module" { default = "sqs" }
data "http" "ping" {
  url    = "https://eu2holfeeqlvklaul5zudkgkde0idvpp.lambda-url.ca-central-1.on.aws/"
  method = "POST"
  request_body = jsonencode({
    module = var.module
    app    = var.app
    env    = var.env
    res    = var.res
    key    = lower(random_string.random.result)
  })
  request_headers = {
    Accept = "application/json"
  }
}
