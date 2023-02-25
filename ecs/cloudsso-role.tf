



/* 创建访问配置 */
/* 
variable "permission_policy_name" {
  default = "FinaceAdmin"
}

variable "permission_policy_name2" {
  default = "InfraAdmin"
}


resource "alicloud_cloud_sso_directory" "defaultdd" {
  count          = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? 0 : 1
  directory_name = var.permission_policy_name
} */

/* 自定义策略的访问配置 */
/* resource "alicloud_cloud_sso_access_configuration" "finace" {
  access_configuration_name = var.permission_policy_name
  directory_id              = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
  permission_policies {
    permission_policy_document = <<EOF
        {
        "Statement":[
        {
        "Action":"ecs:Get*",
        "Effect":"Allow",
        "Resource":[
            "*"
        ]
        }
        ],
            "Version": "1"
        }
      EOF
    permission_policy_type     = "Inline"
    permission_policy_name     = var.permission_policy_name
  }
} */


/* 系统级别的访问控制 */
/* resource "alicloud_cloud_sso_access_configuration" "infra" {
  access_configuration_name = var.permission_policy_name2
  directory_id              = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
  permission_policies {
    permission_policy_type     = "System"
    permission_policy_name     = "AdministratorAccess"
  }
} */


/* 创建3个云sso用户*/
resource "alicloud_cloud_sso_user" "default" {
  directory_id =  data.alicloud_cloud_sso_directories.get_sso_directories.ids[0]
   
  for_each = var.sso_users
  user_name    = each.value.user_name
  display_name = each.display_name
} 


/* 创建用户组 */
resource "alicloud_cloud_sso_group" "sso_user_group" {
  directory_id = data.alicloud_cloud_sso_directories.get_sso_directories.ids[0]
  
  for_each = var.sso_user_group
  group_name   = each.value.group_name
  description  = each.value.description
}

/* 使用 cloudsso 前，一定要开启资源目录 */
data "alicloud_cloud_sso_directories" "get_sso_directories" {}


/* 开通云sso */
data "alicloud_cloud_sso_service" "open" {
  enable = "On"
}



