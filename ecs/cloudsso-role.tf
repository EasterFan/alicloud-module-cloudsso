


/* 创建访问配置 */

variable "permission_policy_name" {
  default = "FinaceAdmin"
}

variable "permission_policy_name2" {
  default = "InfraAdmin"
}


resource "alicloud_cloud_sso_directory" "default" {
  count          = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? 0 : 1
  directory_name = var.permission_policy_name
}

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
resource "alicloud_cloud_sso_access_configuration" "infra" {
  access_configuration_name = var.permission_policy_name2
  directory_id              = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
  permission_policies {
    permission_policy_type     = "System"
    permission_policy_name     = "AdministratorAccess"
  }
}


/* 创建3个云sso用户 - change to list */
variable "cloud_sso_user_name" {
  default = "fdf"
}
data "alicloud_cloud_sso_directories" "default" {
    depends_on = [data.alicloud_cloud_sso_service.open]
}

resource "alicloud_cloud_sso_directory" "default2" {
  count          = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? 0 : 1
  directory_name = var.cloud_sso_user_name
}
resource "alicloud_cloud_sso_user" "default" {
  directory_id = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
  user_name    = var.cloud_sso_user_name
}

/* 开通云sso */
data "alicloud_cloud_sso_service" "open" {
  enable = "On"
}



