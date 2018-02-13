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
