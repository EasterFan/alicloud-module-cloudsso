data "alicloud_resource_manager_folders" "CoreFolder" {
  depends_on = [alicloud_resource_manager_folder.line1_folder]
  output_file = "./classes.txt"
}

output "foldersName" {
  value = "${data.alicloud_resource_manager_folders.CoreFolder}"
}




/* 创建 Core 下的3个成员账号 - aliyun 并发问题，产品缺陷，只能拆开写 */

/* 常规写法如下 */
/* resource "alicloud_resource_manager_account" "application_account" {
   depends_on = [alicloud_resource_manager_folder.line1_folder]
   count = length(var.application_account_names)
   display_name = var.application_account_names[count.index]
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.1.id}"
} */
resource "alicloud_resource_manager_account" "core_account_infra" {
   depends_on = [alicloud_resource_manager_folder.line1_folder]
   display_name = var.account_names[0].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}

resource "alicloud_resource_manager_account" "core_account_log" {
   depends_on = [alicloud_resource_manager_account.core_account_infra]
   display_name = var.account_names[1].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}

resource "alicloud_resource_manager_account" "core_account_soc" {
   depends_on = [alicloud_resource_manager_account.core_account_log]
   display_name = var.account_names[2].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}


/* 创建 Application 下的多个业务成员账号 */
resource "alicloud_resource_manager_account" "app_account_bg1p" {
   depends_on = [alicloud_resource_manager_account.core_account_soc]
   display_name = var.application_account_names[0].value
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}

/* 为了提高速度，先注释 */

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
   count = length(var.folder_names)
   folder_name = var.folder_names[count.index]
}


# 创建资源目录
resource "alicloud_resource_manager_resource_directory" "fdf_directory" {
  status = "Disabled"
}

