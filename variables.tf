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

/* =====================================================vpc============================================================= */


variable "region" { default = "" }      # takes region id as workspace name
variable "region_abbr" { default = "" } # see: https://github.com/hanyouqing/terraform-alicloud-infra/blob/master/variables.tf#L35

variable "vpc_name" { default = "" }
variable "vpc_description" { default = "" }
variable "vpc_cidr_block" { default = "" } # 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
variable "vpc_availability_zone" { default = "" }
variable "vpc_inner_access_policy" { default = "" }
variable "vpc_whitelist_ips" { default = "" }
variable "vpc_sg_policy_ssh" { default = "" }
variable "vpc_sg_policy_http" { default = "" }
variable "vpc_sg_policy_https" { default = "" }

/* =====================================================OOS运维编排============================================================= */



