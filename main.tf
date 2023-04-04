terraform {
  required_providers {
    alicloud = {
      source  = "alicloud"
      version = ">= 1.201.2"
    }
  }
}

provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "cn-shanghai"

  /* endpoints {
     cloudsso = "cloudsso.cn-shanghai.aliyuncs.com"
     vpc = "vpc-vpc.cn-shanghai.aliyuncs.com" 
  } */
}

module "resource_manager" {
  source = "./modules/terraform-alicloud-resource_manager-ing"
}

module "cloudsso" {
  source     = "./modules/terraform-alicloud-cloudsso"
  depends_on = [module.resource_manager]
}

/* module "vpc_hub" {
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
  tags                    = var.tags
  region                  = "cn-shanghai"
} */

/* module "vpc_prd" {
  source                  = "./modules/terraform-alicloud-vpc"
  vpc_name                = var.vpc_prd_name
  vpc_description         = var.vpc_prd_description
  vpc_cidr_block          = lookup(var.cidr_blocks, var.region_abbr)
  vpc_availability_zone   = var.vpc_prd_availability_zone
  vpc_inner_access_policy = var.vpc_prd_inner_access_policy
  vpc_whitelist_ips       = var.vpc_prd_whitelist_ips
  vpc_sg_policy_ssh       = var.vpc_prd_sg_policy_ssh
  vpc_sg_policy_http      = var.vpc_prd_sg_policy_http
  vpc_sg_policy_https     = var.vpc_prd_sg_policy_https
  tags                    = var.tags
  region                  = "cn-shanghai"
}


module "vpc_non_prod" {
  source                  = "./modules/terraform-alicloud-vpc"
  vpc_name                = var.vpc_non_prd_name
  vpc_description         = var.vpc_non_prd_description
  vpc_cidr_block          = lookup(var.cidr_blocks, var.region_abbr)
  vpc_availability_zone   = var.vpc_non_prd_availability_zone
  vpc_inner_access_policy = var.vpc_non_prd_inner_access_policy
  vpc_whitelist_ips       = var.vpc_non_prd_whitelist_ips
  vpc_sg_policy_ssh       = var.vpc_non_prd_sg_policy_ssh
  vpc_sg_policy_http      = var.vpc_non_prd_sg_policy_http
  vpc_sg_policy_https     = var.vpc_non_prd_sg_policy_https
  tags                    = var.tags
  region                  = "cn-shanghai"
} */