resource "random_integer" "wait" {
  min = 1
  max = 120
}
resource "null_resource" "previous" {}
resource "time_sleep" "wait" {
  depends_on      = [null_resource.previous]
  create_duration = "${random_integer.wait.result}s"
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait]
}
