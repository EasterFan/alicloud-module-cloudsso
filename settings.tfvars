
# variables for common
region       = "cn-shanghai"
region_abbr  = "sh"

tags = {
    environment = "testing"     # develop|testing|staging|production
    department  = "infrastructure"
    createby    = "ihanyouqing@gmail.com"
    project     = "icmdb"
    service     = "iwebhook"
    owner       = "icmdb"
    provisioner = "terraform"
}


# variables for vpc_hub
vpc_hub_name                = "hub-tf"
vpc_hub_description         = "icmdb"
vpc_hub_availability_zone   = "cn-shanghai-a"
vpc_hub_inner_access_policy = "Drop"            # Accept|Drop, allow from all in the same security group
vpc_hub_whitelist_ips       = "106.38.171.130"
vpc_hub_sg_policy_ssh       = "accept"          # accept|drop
vpc_hub_sg_policy_http      = "accept"
vpc_hub_sg_policy_https     = "drop"


# variables for vpc_prd
vpc_prd_name                = "prd-tf"
vpc_prd_description         = "icmdb"
vpc_prd_availability_zone   = "cn-shanghai-a"
vpc_prd_inner_access_policy = "Drop"            # Accept|Drop, allow from all in the same security group
vpc_prd_whitelist_ips       = "106.38.171.130"
vpc_prd_sg_policy_ssh       = "accept"          # accept|drop
vpc_prd_sg_policy_http      = "accept"
vpc_prd_sg_policy_https     = "drop"


# variables for vpc_non_prd
vpc_non_prd_name                = "non-prd-tf"
vpc_non_prd_description         = "icmdb"
vpc_non_prd_availability_zone   = "cn-shanghai-a"
vpc_non_prd_inner_access_policy = "Drop"            # Accept|Drop, allow from all in the same security group
vpc_non_prd_whitelist_ips       = "106.38.171.130"
vpc_non_prd_sg_policy_ssh       = "accept"          # accept|drop
vpc_non_prd_sg_policy_http      = "accept"
vpc_non_prd_sg_policy_https     = "drop"

