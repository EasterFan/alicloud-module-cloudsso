/* =====================================================资源目录=================================================================== */

variable "folder_data" {
  type = list(object({
    folder_name         = string
    account_name        = string
    account_name_prefix = string
  }))
  default = [
    { folder_name = "Core", account_name = "GG-DO", account_name_prefix = "GG-DO" },
    { folder_name = "Core", account_name = "GG-LOG", account_name_prefix = "GG-LOG" },
    { folder_name = "Core", account_name = "GG-Maintain", account_name_prefix = "GG-Maintain" },
    { folder_name = "Core", account_name = "GG-Security", account_name_prefix = "GG-Security" },
    { folder_name = "Application", account_name = "GG-BG1-PROD", account_name_prefix = "GG-BG1-PROD" },
    { folder_name = "Application", account_name = "GG-BG1-NON-PROD", account_name_prefix = "GG-BG1-NON-PROD" },
    { folder_name = "Application", account_name = "GG-BG2-PROD", account_name_prefix = "GG-BG2-PROD" },
    { folder_name = "Application", account_name = "GG-BG2-NON-PROD", account_name_prefix = "GG-BG2-NON-PROD" }
  ]
}
/* ================================================================================================================ */
