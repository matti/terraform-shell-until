variable "depends_id" {
  default = ""
}

variable "command" {
  default = ""
}

variable "exit_status_must_equal" {
  default = ""
}

variable "stdout_must_include" {
  default = ""
}

variable "stdout_must_not_include" {
  default = ""
}

variable "max_tries" {
  default = 60
}

variable "interval" {
  default = 1
}

data "external" "shell" {
  program = ["ruby", "${path.module}/shell.rb"]

  query = {
    depends_id              = "${var.depends_id}"
    exit_status_must_equal  = "${var.exit_status_must_equal}"
    stdout_must_include     = "${var.stdout_must_include}"
    stdout_must_not_include = "${var.stdout_must_not_include}"
    interval                = "${var.interval}"
    max_tries               = "${var.max_tries}"
    command                 = "${var.command}"
  }
}

output "result" {
  value = "${data.external.shell.result}"
}
