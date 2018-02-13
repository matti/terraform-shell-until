module "shell" {
  source = ".."

  command = "ls -l"

  exit_status_must_equal = 0
  stdout_must_include    = "terraform"

  #stdout_must_not_include = "terraform"
}

output "result" {
  value = "${module.shell.result}"
}
