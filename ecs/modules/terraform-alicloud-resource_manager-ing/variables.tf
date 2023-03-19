/* =====================================================资源目录=================================================================== */

variable "folder_data"{
  type = list(object({
    folder_name  = string
    account_name = string
    account_name_prefix = string
  }))
  default = [
    { folder_name = "Core", account_name = "NSB-DO", account_name_prefix = "NSB-DO" },
    { folder_name = "Core", account_name = "NSB-LOG", account_name_prefix = "NSB-LOG" },
    { folder_name = "Core", account_name = "NSB-Maintain", account_name_prefix = "NSB-Maintain" },
    { folder_name = "Core", account_name = "NSB-Security", account_name_prefix = "NSB-Security" },
    { folder_name = "Application", account_name = "NSB-BG1-PROD" , account_name_prefix = "NSB-BG1-PROD"},
    { folder_name = "Application", account_name = "NSB-BG1-NON-PROD" , account_name_prefix = "NSB-BG1-NON-PROD"},
    { folder_name = "Application", account_name = "NSB-BG2-PROD" , account_name_prefix = "NSB-BG2-PROD"},
    { folder_name = "Application", account_name = "NSB-BG2-NON-PROD" , account_name_prefix = "NSB-BG2-NON-PROD"}
  ]
}

/* ================================================================================================================ */


variable "custom_var" {
  default = ""
}