

data "alicloud_resource_manager_folders" "CoreFolder" {
  depends_on = [alicloud_resource_manager_folder.line1_folder]
}

/* 创建 Application 下的多个业务成员账号 */
resource "alicloud_resource_manager_account" "application_account" {
   depends_on = [alicloud_resource_manager_folder.line1_folder]
   count = length(var.application_account_names)
   display_name = var.application_account_names[count.index]
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.1.id}"
}

/* 创建 Core 下的3个成员账号 */
resource "alicloud_resource_manager_account" "line2_account" {
   depends_on = [alicloud_resource_manager_folder.line1_folder]
   count = length(var.account_names)
   display_name = var.account_names[count.index]
   folder_id = "${data.alicloud_resource_manager_folders.CoreFolder.folders.0.id}"
}


/* 创建 Core 和 Application 资源夹 */
resource "alicloud_resource_manager_folder" "line1_folder" {
   depends_on = [alicloud_resource_manager_resource_directory.fdf_directory]
   count = length(var.folder_names)
   folder_name = var.folder_names[count.index]
}


# 创建资源目录
resource "alicloud_resource_manager_resource_directory" "fdf_directory" {
  status = "Enabled"
}

