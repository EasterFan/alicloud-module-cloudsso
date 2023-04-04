
# variables for common
region      = "cn-shanghai"
region_abbr = "sh"

tags = {
  environment = "testing" # develop|testing|staging|production
  department  = "infrastructure"
  createby    = "ihanyouqing@gmail.com"
  project     = "icmdb"
  service     = "iwebhook"
  owner       = "icmdb"
  provisioner = "terraform"
}


vpcs = [
  {
    # variables for vpc_hub
    vpc_name                = "hub-tf"
    vpc_description         = "icmdb"
    vpc_availability_zone   = "cn-shanghai-a"
    vpc_inner_access_policy = "Drop" # Accept|Drop, allow from all in the same security group
    vpc_whitelist_ips       = "106.38.171.130"
    vpc_sg_policy_ssh       = "accept" # accept|drop
    vpc_sg_policy_http      = "accept"
    vpc_sg_policy_https     = "drop"
  },

  {
    # variables for vpc_prd
    vpc_name                = "prd-tf"
    vpc_description         = "icmdb"
    vpc_availability_zone   = "cn-shanghai-a"
    vpc_inner_access_policy = "Drop" # Accept|Drop, allow from all in the same security group
    vpc_whitelist_ips       = "106.38.171.130"
    vpc_sg_policy_ssh       = "accept" # accept|drop
    vpc_sg_policy_http      = "accept"
    vpc_sg_policy_https     = "drop"
  },

  {
    # variables for vpc_non_prd
    vpc_name                = "non-prd-tf"
    vpc_description         = "icmdb"
    vpc_availability_zone   = "cn-shanghai-a"
    vpc_inner_access_policy = "Drop" # Accept|Drop, allow from all in the same security group
    vpc_whitelist_ips       = "106.38.171.130"
    vpc_sg_policy_ssh       = "accept" # accept|drop
    vpc_sg_policy_http      = "accept"
    vpc_sg_policy_https     = "drop"
  }
]











