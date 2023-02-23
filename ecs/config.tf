/* variable "name" {
  default = "rulename"
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

/* data "alicloud_instances" "default" {} */
/* 
data "alicloud_config_rules" "example" {
  name_regex = "oss*"
}

output "first_config_rule_id" {
  value = data.alicloud_config_rules.example.rules.0.id
}  */

/* output "first_config_aggregate_config_rule_id" {
  value = data.alicloud_config_aggregate_config_rules.example.rules.0.id
} */

/* resource "alicloud_config_aggregator" "default" {
  aggregator_accounts {
    account_id   = "140278452670****"
    account_name = "test-2"
    account_type = "ResourceDirectory"
  }
  aggregator_name = "oss最佳实践合规包ddd"
  description     = "tf-testaccaggregator"
} */


/* 创建合规配置包 */
/* 
resource "alicloud_config_aggregate_compliance_pack" "default" {
  aggregate_compliance_pack_name = "oss最佳实践合规包aaa"
  aggregator_id                  = alicloud_config_aggregator.default.id
  description                    = "tf-testaccConfig1234"
  risk_level                     = 1
  config_rule_ids {
    config_rule_id = alicloud_config_aggregate_config_rule.default.config_rule_id
  }
} */

/* 创建账号组 */



