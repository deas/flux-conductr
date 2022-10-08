terraform {
  required_version = ">= 0.12.26"
}

variable "env" {
  type        = string
  default     = "none"
}

output "hello_env" {
  value = "Hello, ${var.env}!"
}
