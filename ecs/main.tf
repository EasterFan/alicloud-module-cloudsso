terraform {
  required_providers {
    alicloud = {
      source = "alicloud"
      version = ">= 1.201.2"
    }
  }
}

provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "cn-hangzhou"

  endpoints {
     cloudsso = "cloudsso.cn-shanghai.aliyuncs.com"
     /* vpc = "vpc-vpc.cn-shanghai.aliyuncs.com" */
  }
}

/* provider "alicloud-do" {
  assume_role {
    role_arn           = "acs:ram::1117678625002664:role/aliyunreservedsso-administrator"
    policy             = "POLICY"
    session_name       = "SESSION_NAME"
    session_expiration = 999
  }
} */

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
    region     = "cn-shanghai"
}
