# @reference:
#   https://www.terraform.io/docs/configuration/outputs.html
#
output "motd" {
    description = "Message of the day, always goes advertisment."
    value = var.motd
}
output "name" {
    description = "The name of vpc."
    value = alicloud_vpc.infra.name
}
output "vpc" {
    description = "Details of vpc"
    value = {
        "id": alicloud_vpc.infra.id,
        "cidr_block": alicloud_vpc.infra.cidr_block,
        "name": alicloud_vpc.infra.name,
        "description": alicloud_vpc.infra.description,
        "router_id ": alicloud_vpc.infra.router_id,
        "route_table_id": alicloud_vpc.infra.route_table_id,
        "reference": "https://www.terraform.io/docs/providers/alicloud/r/vpc.html",
    }
}
output "vswitch" {
    description = "Details of "
    value = {
        "id": alicloud_vswitch.infra.id,
        "availability_zone": alicloud_vswitch.infra.availability_zone,
        "cidr_block": alicloud_vswitch.infra.cidr_block,
        "vpc_id": alicloud_vswitch.infra.vpc_id,
        "name ": alicloud_vswitch.infra.name,
        "description": alicloud_vswitch.infra.description,
        "reference": "https://www.terraform.io/docs/providers/alicloud/r/vswitch.html",
    }
}
output "sg" {
    description = "Details of secure group."
    value = {
        "id": alicloud_security_group.infra.id,
        "name": alicloud_security_group.infra.name,
        "reference": "https://www.terraform.io/docs/providers/alicloud/r/security_group.html",
    }
}
output "sg_rules" {
    description = "Rules of secure group."
    value = [
        {
            "name": "whitelist",
            "id": alicloud_security_group_rule.whitelist.id,
            "type": alicloud_security_group_rule.whitelist.type,
            # "name": alicloud_security_group_rule.whitelist.name,
            "port_range": alicloud_security_group_rule.whitelist.port_range,
            "ip_protocol": alicloud_security_group_rule.whitelist.ip_protocol,
        },
        {
            "name": "default",
            "id": alicloud_security_group_rule.default.id,
            "type": alicloud_security_group_rule.default.type,
            "port_range": alicloud_security_group_rule.default.port_range,
            "ip_protocol": alicloud_security_group_rule.default.ip_protocol,
        },
        {
            "name": "ssh",
            "id": alicloud_security_group_rule.ssh.id,
            "type": alicloud_security_group_rule.ssh.type,
            "port_range": alicloud_security_group_rule.ssh.port_range,
            "ip_protocol": alicloud_security_group_rule.ssh.ip_protocol,
        },
        {
            "name": "http",
            "id": alicloud_security_group_rule.http.id,
            "type": alicloud_security_group_rule.http.type,
            "port_range": alicloud_security_group_rule.http.port_range,
            "ip_protocol": alicloud_security_group_rule.http.ip_protocol,
        },
        {
            "name": "https",
            "id": alicloud_security_group_rule.https.id,
            "type": alicloud_security_group_rule.https.type,
            "port_range": alicloud_security_group_rule.https.port_range,
            "ip_protocol": alicloud_security_group_rule.https.ip_protocol,
        },
    ]
}
output "whitelist" {
    description = "The whitelist ips, should seprated by comma"
    value = var.vpc_whitelist_ips
}