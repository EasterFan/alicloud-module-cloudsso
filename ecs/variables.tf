variable "project_name" {
  default     = "yuner"
  description = "Project Name"
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
  type = list(object({
    group_name = string
    user_name = string
    display_name = string
    comments     = string
  }))
  default = [
   {
      group_name = "NSB-Log"
      user_name = "fandongfang"
      display_name = "樊东方"
      comments     = "云sso用户"
    },
    {
      group_name = "NSB-Log"
      user_name = "fandongfang2"
      display_name = "樊东方2"
      comments     = "云sso用户"
    },
    {
      group_name = "NSB-Security"
      user_name = "weiliheng"
      display_name = "魏立恒"
      comments     = "云sso用户"
    },
    {
      group_name = "NSB-DO-Master"
      user_name = "shenbinbin"
      display_name = "沈彬彬"
      comments     = "云sso用户"
    }]
}



/* =====================================================资源目录=================================================================== */

variable "folder_data"{
  type = list(object({
    folder_name  = string
    account_name = string
  }))
  default = [
    { folder_name = "Core", account_name = "NSB-DO" },
    { folder_name = "Core", account_name = "NSB-LOG" },
    { folder_name = "Core", account_name = "NSB-Security" },
    { folder_name = "Application", account_name = "NSB-BG1-PROD" },
    { folder_name = "Application", account_name = "NSB-BG1-NON-PROD" },
    { folder_name = "Application", account_name = "NSB-BG2-PROD" },
    { folder_name = "Application", account_name = "NSB-BG2-NON-PROD" }
  ]
}

/* ================================================================================================================ */

