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
