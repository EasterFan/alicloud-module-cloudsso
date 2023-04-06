terraform {
  required_providers {
    alicloud = {
      source  = "alicloud"
      version = ">= 1.201.2"
    }
  }
}

provider "alicloud" {
  access_key = "LTAI5tHWYiMGrXBQb8qqq9uj"
  secret_key = "23C1PGI80p6MeR8E1zO3QrWXVgJPCv"
  region     = "cn-shanghai"
}

variable "cen_name" { default = "nsb_project" }
variable "project_prefix" { default = "nsb_project" }

resource "alicloud_cen_instance" "cen" {
  cen_instance_name = var.cen_name
  description       = "复现ECS和RDS网络不通问题"
}


resource "alicloud_cen_transit_router" "default" {
  transit_router_name = "FDF_TR"
  cen_id              = alicloud_cen_instance.cen.id
}

/* resource "alicloud_cen_instance_grant" "foo" {
  cen_id            = alicloud_cen_instance.cen.id
  child_instance_id = data.alicloud_vpcs.default.ids.0
  cen_owner_id      = "1129140695538589"
} */

resource "alicloud_cen_transit_router_grant_attachment" "tr_attach" {
  cen_id        = alicloud_cen_instance.cen.id
  cen_owner_id  = "1129140695538589"
  instance_id   = data.alicloud_vpcs.default.ids.0
  instance_type = "VPC"
  order_type    = "PayByCenOwner"
  /* depends_on    = [alicloud_cen_instance_grant.foo] */
}

data "alicloud_vpcs" "default" {
  name_regex = "${var.project_prefix}*"
}