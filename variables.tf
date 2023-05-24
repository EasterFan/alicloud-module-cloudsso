variable "project_info" {
  type = object({
    prefix = string
  })
  default = {
    prefix = "NSB"
  }
}

variable "tags" {
  /* type = string */
  default = {
    createdby = "terraform"
  }
}

variable "access_key" { default = "" }
variable "secret_key" { default = "" }


variable "env_dev" { default = "dev" }
variable "project_prefix" { default = "" }


