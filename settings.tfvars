
# variables for common
region         = "cn-shanghai"
region_abbr    = "sh"
project_prefix = "nsb_project"

tags = {
  environment = "testing" # develop|testing|staging|production
  department  = "infrastructure"
  createby    = "ihanyouqing@gmail.com"
  project     = "icmdb"
  service     = "iwebhook"
  owner       = "icmdb"
  provisioner = "terraform"
}


# variables for vpc_hub
vpc_name                = "hub-tf"
vpc_description         = "此VPC随时会被删除,勿部署重要应用"
vpc_availability_zone   = "cn-shanghai-a"
vpc_inner_access_policy = "Drop" # Accept|Drop, allow from all in the same security group
vpc_whitelist_ips       = "106.38.171.130"
vpc_sg_policy_ssh       = "accept" # accept|drop
vpc_sg_policy_http      = "accept"
vpc_sg_policy_https     = "drop"









