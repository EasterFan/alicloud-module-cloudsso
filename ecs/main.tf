terraform {
  required_providers {
    alicloud = {
      source = "alicloud"
    }
  }
}

provider "alicloud" {
  access_key = "LTAI5tJptEE1EL94w8xG1qSB"
  secret_key = "a89REYYYNCdvMU2xYKSBNZgaMCIQkL"
  region     = "cn-hangzhou"

  endpoints {
     cloudsso = "cloudsso.cn-shanghai.aliyuncs.com"
  } 
}
/* 
module "vpc" {
    # source                  = "hanyouqing/vpc/alicloud"
    source                  = "./modules/terraform-alicloud-vpc"
    vpc_name                = var.vpc_name
    vpc_description         = var.vpc_description
    vpc_cidr_block          = lookup(var.cidr_blocks, var.region_abbr)
    vpc_availability_zone   = var.vpc_availability_zone
    vpc_inner_access_policy = var.vpc_inner_access_policy
    vpc_whitelist_ips       = var.vpc_whitelist_ips
    vpc_sg_policy_ssh       = var.vpc_sg_policy_ssh
    vpc_sg_policy_http      = var.vpc_sg_policy_http
    vpc_sg_policy_https     = var.vpc_sg_policy_https

    tags = var.tags
} */
