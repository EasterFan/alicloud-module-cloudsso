
locals{
     /* 构建username 和 userid 的map, 通过 name 取ID */
  folderMap = { for folder in data.alicloud_resource_manager_folders.CoreFolder.folders :
            folder.folder_name => folder.folder_id }
}
data "alicloud_resource_manager_folders" "CoreFolder" {
  depends_on = [alicloud_resource_manager_folder.line1_folder]
  output_file = "./classes.txt"
}



/* 创建 Core 下的3个成员账号 - aliyun 并发问题，产品摆烂，只能拆开写 */

/* ==============================常规写法如下================================================= */
/* resource "alicloud_resource_manager_account" "application_account" {
   depends_on = [alicloud_resource_manager_folder.line1_folder]
   count = length(var.application_account_names)
   display_name = var.application_account_names[count.index]
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.1.id}"
} */
/* =============================================================================== */

resource "alicloud_resource_manager_account" "core_account_infra" {
   depends_on = [alicloud_resource_manager_folder.line1_folder]
   display_name = var.folder_data[0].account_name
   account_name_prefix = var.folder_data[0].account_name_prefix
   folder_id = lookup(local.folderMap, var.folder_data[0].folder_name)
}

resource "alicloud_resource_manager_account" "core_account_log" {
   depends_on = [alicloud_resource_manager_account.core_account_infra]
   display_name = var.folder_data[1].account_name
   account_name_prefix = var.folder_data[1].account_name_prefix
   folder_id = lookup(local.folderMap, var.folder_data[1].folder_name)
}

resource "alicloud_resource_manager_account" "core_account_soc" {
   depends_on = [alicloud_resource_manager_account.core_account_log]
   display_name = var.folder_data[2].account_name
   account_name_prefix = var.folder_data[2].account_name_prefix
   folder_id = lookup(local.folderMap, var.folder_data[2].folder_name)
}

resource "alicloud_resource_manager_account" "app_account_maintain" {
   depends_on = [alicloud_resource_manager_account.core_account_soc]
   display_name = var.folder_data[3].account_name
   account_name_prefix = var.folder_data[3].account_name_prefix
   folder_id = lookup(local.folderMap, var.folder_data[3].folder_name)
}


/* 创建 Application 下的多个业务成员账号 */
resource "alicloud_resource_manager_account" "app_account_bg1p" {
   depends_on = [alicloud_resource_manager_account.app_account_maintain]
   display_name = var.folder_data[4].account_name
   account_name_prefix = var.folder_data[4].account_name_prefix
   folder_id = lookup(local.folderMap, var.folder_data[4].folder_name)
}

/* 为了提高 destory 速度，先注释 */

/* resource "alicloud_resource_manager_account" "app_account_bg1n" {
   depends_on = [alicloud_resource_manager_account.app_account_bg1p]
   display_name = var.application_account_names[1].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}

resource "alicloud_resource_manager_account" "app_account_bg2p" {
   depends_on = [alicloud_resource_manager_account.app_account_bg1n]
   display_name = var.application_account_names[2].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}

resource "alicloud_resource_manager_account" "app_account_bg2n" {
   depends_on = [alicloud_resource_manager_account.app_account_bg2p]
   display_name = var.application_account_names[3].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
} */

/* 创建 Core 和 Application 资源夹 */
resource "alicloud_resource_manager_folder" "line1_folder" {
   depends_on = [alicloud_resource_manager_resource_directory.fdf_directory]
   for_each = toset([for folder in var.folder_data : folder.folder_name])
   folder_name = each.key
}


# 创建资源目录
resource "alicloud_resource_manager_resource_directory" "fdf_directory" {
  status = "Disabled"
  /* 删除成员许可开启 */
  member_deletion_status = "Enabled"
}

