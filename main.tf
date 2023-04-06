terraform {
  required_providers {
    alicloud = {
      source  = "alicloud"
      version = ">= 1.201.2"
    }
  }
}

provider "alicloud" {
  alias      = "master_account_1129140695538589"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "cn-shanghai"
}

module "resource_manager" {
  providers = {
    alicloud = alicloud.master_account_1129140695538589
  }
  source = "./modules/terraform-alicloud-resource_manager-ing"
}

module "cloudsso" {
  providers = {
    alicloud = alicloud.master_account_1129140695538589
  }
  source     = "./modules/terraform-alicloud-cloudsso"
  depends_on = [module.resource_manager]
}


module "vpc_hub" {
  source = "./modules/terraform-alicloud-vpc"
  /* provider = master_account_1129140695538589 */
  providers = {
    alicloud = alicloud.master_account_1129140695538589
  }
  create          = "true"
  vpc_name        = "${var.env_dev}-${var.project_prefix}-vpc-sh"
  vpc_description = "nsb vpc-hub 专用"
  vpc_cidr        = "10.192.0.0/24"
  vpc_tags = {
    application = "dev_app100"
    owner       = "Frank"
  }
  vswitch_tags = {
    application = "dev_app100"
    owner       = "Frank"
  }
  vswitch_cidrs       = tolist(split(",", "10.192.0.0/28,10.192.0.64/26,10.192.0.128/25"))
  availability_zones  = tolist(split(",", "cn-shanghai-f,cn-shanghai-g,cn-shanghai-g"))
  vswitch_name        = tolist(split(",", "${var.env_dev}-${var.project_prefix}-vsw-sh-f-tr,${var.env_dev}-${var.project_prefix}-vsw-sh-g-k8s,${var.env_dev}-${var.project_prefix}-vsw-sh-g-pod"))
  vswitch_description = ""
}


/* module "vpc_hub" {
  # source                  = "hanyouqing/vpc/alicloud"
  source                  = "./modules/terraform-alicloud-vpc"
  vpc_name                = "${var.project_prefix}-${var.vpc_name}"
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