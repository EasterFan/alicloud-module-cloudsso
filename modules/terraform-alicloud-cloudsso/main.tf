locals {
  sso_relation_configs = flatten([
    for account, relation in var.sso_access_relation_name : [
      for group_or_user in relation.deploy_user_group : [
        for role in group_or_user.deploy_access_list : {
          account_name       = account,
          relation_name      = relation.sso_relation_name,
          description        = relation.description,
          deploy_target_type = group_or_user.target_type,
          deploy_target_name = group_or_user.target_name,
          access_list        = role
        }
      ]
    ]
  ])

  /* 构建username 和 userid 的map, 通过 name 取ID */
  configurationMap = { for user in data.alicloud_cloud_sso_access_configurations.access_configurations.configurations :
  user.access_configuration_name => user.access_configuration_id }
  accountMap = { for user in data.alicloud_resource_manager_accounts.default.accounts :
  user.display_name => user.account_id }

  /* 访问控制的自定义策略和系统策略分组 */
  access_with_system = { for key, item in var.sso_access : key => item if null == item.custom_policy }
  access_with_custom = { for key, item in var.sso_access : key => item if null != item.custom_policy }

}

data "alicloud_cloud_sso_access_configurations" "access_configurations" {
  depends_on   = [alicloud_cloud_sso_access_configuration.sso_system_access, alicloud_cloud_sso_access_configuration.sso_custom_access]
  directory_id = local.directory_id
}

/* todo: 日后修改成最后一个账号 */
data "alicloud_resource_manager_accounts" "default" {
  /* depends_on = [alicloud_resource_manager_account.app_account_bg1p] */
  /* depends_on = [module.resource_manager.alicloud_resource_manager_account] */
}

/* 将分配的权限配置到指定的账号 */
resource "alicloud_cloud_sso_access_configuration_provisioning" "provisioning" {
  depends_on = [alicloud_cloud_sso_access_configuration.sso_custom_access, alicloud_cloud_sso_access_configuration.sso_system_access, alicloud_cloud_sso_group.sso_user_group]
  for_each = {
    for index, relation_config in local.sso_relation_configs :
    index => relation_config
  }

  directory_id            = local.directory_id
  access_configuration_id = lookup(local.configurationMap, each.value.access_list, "tmp")
  target_id               = lookup(local.accountMap, each.value.account_name, "tmp")
  target_type             = "RD-Account"

}

/* 将分配的权限附加到指定的用户或组上 */
resource "alicloud_cloud_sso_access_assignment" "assignment" {
  depends_on = [alicloud_cloud_sso_access_configuration_provisioning.provisioning]

  for_each = {
    for relation_config in local.sso_relation_configs :
    "${relation_config.account_name}:${relation_config.access_list}:${relation_config.deploy_target_type}:${relation_config.deploy_target_name}" => relation_config
  }
  directory_id            = local.directory_id
  access_configuration_id = lookup(local.configurationMap, each.value.access_list, "tmp")
  principal_id            = each.value.deploy_target_type == "User" ? lookup(local.usersMap, each.value.deploy_target_name, "tmp") : lookup(local.groupsMap, each.value.deploy_target_name, "tmp")
  principal_type          = each.value.deploy_target_type
  target_id               = lookup(local.accountMap, each.value.account_name, "tmp")
  target_type             = "RD-Account"

}


/* 云sso访问控制：系统策略  */
resource "alicloud_cloud_sso_access_configuration" "sso_system_access" {
  depends_on   = [data.alicloud_cloud_sso_service.open]
  directory_id = local.directory_id

  for_each                  = local.access_with_system
  access_configuration_name = each.value.sso_access_name
  description               = each.value.description

  dynamic "permission_policies" {
    for_each = each.value.system_policy_list
    content {
      permission_policy_type = "System"
      permission_policy_name = permission_policies.value
    }
  }
}

/* 云sso访问控制：自定义策略  */
resource "alicloud_cloud_sso_access_configuration" "sso_custom_access" {
  depends_on = [alicloud_cloud_sso_access_configuration.sso_system_access]

  directory_id = local.directory_id

  for_each                  = local.access_with_custom
  access_configuration_name = each.value.sso_access_name
  description               = each.value.description


  dynamic "permission_policies" {
    for_each = local.access_with_custom
    content {
      permission_policy_type     = "Inline"
      permission_policy_name     = "customs-fdf"
      permission_policy_document = permission_policies.value.custom_policy
    }
  }
}


locals {
  /* 构建username 和 userid 的map, 通过 name 取ID */
  usersMap = { for user in data.alicloud_cloud_sso_users.example.users :
  user.user_name => user.user_id }


  groupsMap = { for user in data.alicloud_cloud_sso_groups.example.groups :
  user.group_name => user.group_id }

}

data "alicloud_cloud_sso_users" "example" {
  depends_on   = [alicloud_cloud_sso_user.sso_user]
  directory_id = local.directory_id
}

# 获取用户组 ID
data "alicloud_cloud_sso_groups" "example" {
  depends_on   = [alicloud_cloud_sso_group.sso_user_group]
  directory_id = local.directory_id
}

# 将用户添加到用户组
resource "alicloud_cloud_sso_user_attachment" "example_attachment" {
  depends_on   = [alicloud_cloud_sso_user.sso_user, alicloud_cloud_sso_group.sso_user_group]
  directory_id = local.directory_id

  for_each = { for user in var.sso_users : user.user_name => user }

  user_id  = lookup(local.usersMap, each.key, "tmp")
  group_id = lookup(local.groupsMap, each.value.group_name, "tmp")
}


/* 创建3个云sso用户*/
resource "alicloud_cloud_sso_user" "sso_user" {
  depends_on   = [data.alicloud_cloud_sso_service.open]
  directory_id = local.directory_id

  /* 将 list 转为 map */
  for_each     = { for user in var.sso_users : user.user_name => user }
  user_name    = each.value.user_name
  display_name = each.value.display_name
}


/* 创建用户组 */
resource "alicloud_cloud_sso_group" "sso_user_group" {
  depends_on   = [data.alicloud_cloud_sso_service.open]
  directory_id = local.directory_id

  for_each    = var.sso_user_group
  group_name  = each.value.group_name
  description = each.value.description
}

locals {
  directory_id = length(data.alicloud_cloud_sso_directories.get_sso_directories.ids) > 0 ? data.alicloud_cloud_sso_directories.get_sso_directories.ids[0] : concat(alicloud_cloud_sso_directory.fdf-cloudsso-directory.*.id, [""])[0]
}

/* 使用 cloudsso 前，一定要获取资源目录 */
data "alicloud_cloud_sso_directories" "get_sso_directories" {
  /* depends_on = [alicloud_cloud_sso_directory.fdf-cloudsso-directory] */
}


resource "alicloud_cloud_sso_directory" "fdf-cloudsso-directory" {
  /* count          = length(data.alicloud_cloud_sso_directories.get_sso_directories.ids) > 0 ? 0 : 1 */
  directory_name = "fdf-cloudsso-directory"
  depends_on     = [data.alicloud_cloud_sso_service.open]
}


/* 开通云sso */
data "alicloud_cloud_sso_service" "open" {
  /* depends_on = [alicloud_resource_manager_resource_directory] */
  enable = "On"
}