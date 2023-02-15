variable "project_name" {
  default     = "yuner"
  description = "Project Name"
}

variable "target_account_id" {
  # tognzhao
  default = "209625040857768767"
  description = "Target account id"
  type        = string
}
















/* =====================================================资源目录=================================================================== */

/* Application 目录下的账号 */
variable "application_account_names" {
  type = list(string)
  default = ["NSB-BG1-PROD", "NSB-BG1-NON-PROD", "NSB-BG2-PROD", "NSB-BG2-NON-PROD"]
}

/* Core 目录下的账号 */
variable "account_names" {
  type = list(string)
  default = ["NSB-DO", "NSB-Log", "NSB-Security"]
}


/* 一级资源目录 */
variable "folder_names" {
  type = list(string)
  default = ["Core", "Application"]
}
/* ================================================================================================================ */



variable "contact_group_name" {
  description = "Name of the contact group"
  type        = string
  default     = "default_contact_group"
}

variable "contact_web_hook_url" {
  // the address of Function Compute to forward alarms
  // or for other application integration
  description = "URL of contact web hook"
  type        = string
  default     = "http://nowebhook.com"
}


variable "second_contact" {
  type = object({
    mail = string
    sms  = string
    lang = string
  })
  default = {
    mail = "test_aliyun_alarm_2@test.com"
    sms  = "12399999999"
    lang = "zh-cn"
  }
}
