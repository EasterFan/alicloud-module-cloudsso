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




/* =====================================================云SSO=================================================================== */



/* 云sso中的用户组 */
variable "sso_user_group" {
  type = map(object({
    group_name      = string
    description     = string
  }))
  default = {
    master = {
      group_name = "NSB-DO-Master"
      description     = "DO 关键组"
    }
    admin = {
      group_name = "NSB-DO-Admin"
      description     = "DO 管理员组"
    }
    finace = {
      group_name = "NSB-DO-Finance"
      description     = "财务组"
    }
    security = {
      group_name = "NSB-Security"
      description     = "安全组"
    }
    log = {
      group_name = "NSB-Log"
      description     = "日志组"
    }
    bgAdmin = {
      group_name = "NSB-BG-Admin"
      description     = "BG 部门管理员"
    }
  }
}


/* 云sso中的用户 */
variable "sso_users" {
  type = map(object({
    user_name = string
    display_name = string
    comments     = string
  }))
  default = {
    fdf = {
      user_name = "fandongfang"
      display_name = "樊东方"
      comments     = "云sso用户"
    }
    vlh = {
      user_name = "weiliheng"
      display_name = "魏立恒"
      comments     = "云sso用户"
    }
    sbb = {
      user_name = "shenbinbin"
      display_name = "沈彬彬"
      comments     = "云sso用户"
    }
  }
}



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
