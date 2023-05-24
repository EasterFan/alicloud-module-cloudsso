variable "region" {
  default = ""
}

/* =====================================================云SSO=================================================================== */

/* 云sso中的账号访问关系数据 账号(key)、用户（组）、权限 */
variable "sso_access_relation_name" {
  type = map(object({
    sso_relation_name = string
    description       = string
    deploy_user_group = list(object({
      target_type        = string
      target_name        = string
      deploy_access_list = list(string)
    }))
  }))

  default = {
    GG-Security = {
      sso_relation_name = "GG-Security-Rule"
      description       = "GG-Security 账号下的权限分配"
      deploy_user_group = [
        {
          target_type        = "User"
          target_name        = "fandongfang"
          deploy_access_list = ["SecurityAdmin"]
        },
        {
          target_type        = "Group"
          target_name        = "GG-Security"
          deploy_access_list = ["SecurityAdmin"]
      }]
    }
    GG-DO = {
      sso_relation_name = "GG-DO-Rule"
      description       = "GG-DO 账号下的权限分配"
      deploy_user_group = [
        {
          target_type        = "User"
          target_name        = "fandongfang"
          deploy_access_list = ["Administrator"]
      }]
    }
  }
}


/* 云sso中的访问配置 */
variable "sso_access" {
  type = map(object({
    sso_access_name    = string
    description        = string
    system_policy_list = list(string)
    custom_policy      = optional(string)
  }))

  default = {
    Administrator = {
      sso_access_name    = "Administrator"
      description        = "负责账号下的所有权限"
      system_policy_list = ["AdministratorAccess"]
    }
    FinaceAdmin = {
      sso_access_name = "FinaceAdmin"
      description     = "负责管理企业财务 （账单 付款 发票等），由GG-DO-Admin团队中部分核心成员扮演"
      system_policy_list = ["AliyunBSSFullAccess",
        "AliyunFinanceConsoleFullAccess",
      "AliyunCloudCommunicationFullAccess"]
    }
    NetworkAdmin = {
      sso_access_name = "NetworkAdmin"
      description     = "负责基础设施网络的运维，由 GG-DO-Network团队人员扮演"
      system_policy_list = ["AliyunVPNGatewayFullAccess",
        "AliyunCommonBandwidthPackageFullAccess",
        "AliyunCDNFullAccess",
        "AliyunExpressConnectFullAccess",
        "AliyunSLBFullAccess",
        "AliyunGlobalAccelerationFullAccess",
        "AliyunSmartAccessGatewayFullAccess",
        "AliyunYundunNewBGPAntiDDoSServicePROFullAccess",
        "AliyunNATGatewayFullAccess",
        "AliyunVPCFullAccess",
      "AliyunBSSFullAccess"]
    }
    DevOpsAdmin = {
      sso_access_name = "DevOpsAdmin"
      description     = "负责应用上云实施，由 GG-DO-DevOps 团队成员扮演"
      system_policy_list = ["AliyunECSFullAccess",
        "AliyunOSSFullAccess",
        "AliyunCSFullAccess",
        "AliyunRDCFullAccess",
        "AliyunContainerRegistryFullAccess",
        "AliyunCloudMonitorFullAccess",
        "AliyunRDSFullAccess",
        "AliyunDRDSFullAccess",
        "ReadOnlyAccess",
      "AliyunBSSFullAccess"]
    }
    SecurityAdmin = {
      sso_access_name = "SecurityAdmin"
      description     = "负责管理企业财务 （账单 付款 发票等），由GG-DO-Admin团队中部分核心成员扮演"
      system_policy_list = ["AliyunActionTrailFullAccess",
        "AliyunConfigFullAccess",
        "AliyunLogFullAccess",
        "AliyunOSSFullAccess",
        "ReadOnlyAccess",
      "AliyunBSSFullAccess"]
    }
    LogAdmin = {
      sso_access_name = "LogAdmin"
      description     = "负责组织下所有账号的日志采集分析工作"
      system_policy_list = ["AliyunLogFullAccess",
      "ReadOnlyAccess"]
    }
    BillingAdmin = {
      sso_access_name = "BillingAdmin"
      description     = "为兼容目前的老账号，负责管理企业财务 （账单 付款 发票等），由GG-DO-Admin团队中部分核心成员扮演"
      system_policy_list = ["AliyunBSSFullAccess",
        "AliyunFinanceConsoleFullAccess",
      "AliyunCloudCommunicationFullAccess"]
    }
    ResourceUser = {
      sso_access_name    = "ResourceUser"
      description        = "应用部门只读权限"
      system_policy_list = ["ReadOnlyAccess"]
      custom_policy      = <<EOF
            {
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Action": [
                            "cr:ListInstance*",
                            "cr:GetInstance*",
                            "cr:ListSignature*"
                        ],
                        "Resource": "*"
                    },
                    {
                        "Action": [
                            "cr:*"
                        ],
                        "Effect": "Allow",
                        "Resource": [
                            "acs:cr:*:*:repository/$instanceid/$namespace/*",
                            "acs:cr:*:*:repository/$instanceid/$namespace"
                        ]
                    },
                    {
                        "Action": [
                            "cr:*"
                        ],
                        "Effect": "Allow",
                        "Resource": [
                            "acs:cr:*:*:repository/$instanceid/*",
                            "acs:cr:*:*:repository/$instanceid/*/*"
                        ]
                    }
                ],
                "Version": "1"
            }
      EOF
    }

  }
}


/* 云sso中的用户组 */
variable "sso_user_group" {
  type = map(object({
    group_name  = string
    description = string
  }))
  default = {
    master = {
      group_name  = "GG-DO-Master"
      description = "DO 关键组"
    }
    admin = {
      group_name  = "GG-DO-Admin"
      description = "DO 管理员组"
    }
    finace = {
      group_name  = "GG-DO-Finance"
      description = "财务组"
    }
    security = {
      group_name  = "GG-Security"
      description = "安全组"
    }
    log = {
      group_name  = "GG-Log"
      description = "日志组"
    }
    bgAdmin = {
      group_name  = "GG-BG-Admin"
      description = "BG 部门管理员"
    }
  }
}


/* 云sso中的用户 */
variable "sso_users" {
  type = list(object({
    group_name   = string
    user_name    = string
    display_name = string
    comments     = string
  }))
  default = [
    {
      group_name   = "GG-Log"
      user_name    = "fandongfang"
      display_name = "樊东方"
      comments     = "云sso用户"
    },
    {
      group_name   = "GG-Log"
      user_name    = "fandongfang2"
      display_name = "樊东方2"
      comments     = "云sso用户"
    },
    {
      group_name   = "GG-Security"
      user_name    = "weiliheng"
      display_name = "魏立恒"
      comments     = "云sso用户"
    },
    {
      group_name   = "GG-DO-Master"
      user_name    = "shenbinbin"
      display_name = "沈彬彬"
      comments     = "云sso用户"
  }]
}
