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