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








/* 云sso中的3个用户 */
/* variable "sso_users" {
  type = list(object)
  default = [{  display_name = "樊东方-SSO", email = ""  },{} ]
} */



/* =====================================================资源目录=================================================================== */

/* Application 目录下的账号 */
variable "application_account_names" {
  type = list(object({
    key = string,
    value = string
  }))
  default = [{key = "bg1p", value = "NSB-BG1-PROD"}, {key = "bg1n", value = "NSB-BG1-NON-PROD"},{key = "bg2p", value = "NSB-BG2-PROD"},{key = "bg2n", value = "NSB-BG2-NON-PROD"}]
}


/* Core 目录下的账号 */
variable "account_names" {
  type = list(object({
    key = string,
    value = string
  }))
  default = [{key = "infra", value = "NSB-DO"}, {key = "log", value = "NSB-LOG"},{key = "soc", value = "NSB-Security"}]
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
