terraform {
  required_version = ">= 1.4.0"
}

provider "alicloud" {
  /* version    = ">= 1.201.2" */
  access_key = "LTAI5tHWYiMGrXBQb8qqq9uj"
  secret_key = "23C1PGI80p6MeR8E1zO3QrWXVgJPCv"
  /* access_key = var.access_key
  secret_key = var.secret_key */
}


module "vpc" {
  source = "../../../terraform-alicloud-vpc"

  for_each = { for idx, vpc in var.vpcs : idx => vpc }

  vpc_name                = each.value.vpc_name
  vpc_description         = each.value.vpc_hub_description
  vpc_cidr_block          = lookup(each.value.cidr_blocks, each.value.region_abbr)
  vpc_availability_zone   = each.value.vpc_hub_availability_zone
  vpc_inner_access_policy = each.value.vpc_hub_inner_access_policy
  vpc_whitelist_ips       = each.value.vpc_hub_whitelist_ips
  vpc_sg_policy_ssh       = each.value.vpc_hub_sg_policy_ssh
  vpc_sg_policy_http      = each.value.vpc_hub_sg_policy_http
  vpc_sg_policy_https     = each.value.vpc_hub_sg_policy_https
  tags                    = each.value.tags
  region                  = "cn-shanghai"
}


