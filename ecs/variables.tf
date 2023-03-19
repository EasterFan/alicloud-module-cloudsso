variable "project_info"{
  type = object({
    prefix  = string
  })
  default = { 
	  prefix = "NSB"
  }
}

variable "tags" {
  /* type = string */
  default = {
      createdby    = "terraform"
    }
}

variable access_key { default = "" }
variable secret_key { default = "" }


/* =====================================================vpc============================================================= */


variable "region"       { default = "" }    # takes region id as workspace name
variable "region_abbr"  { default = "" }    # see: https://github.com/hanyouqing/terraform-alicloud-infra/blob/master/variables.tf#L35

variable "vpc_name"                 { default = "" }
variable "vpc_description"          { default = "" }
variable "vpc_cidr_block"           { default = "" } # 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
variable "vpc_availability_zone"    { default = "" }
variable "vpc_inner_access_policy"  { default = "" }
variable "vpc_whitelist_ips"        { default = "" }
variable "vpc_sg_policy_ssh"        { default = "" }
variable "vpc_sg_policy_http"       { default = "" }
variable "vpc_sg_policy_https"      { default = "" }

variable "cidr_blocks" {
    description = "10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16"
    default = {
        qd    = "192.168.1.0/24"  # cn-qingdao       northchina-1
        bj    = "192.168.2.0/24"  # cn-beijing       northchina-2
        zjk   = "192.168.3.0/24"  # cn-zhangjiakou   northchina-3
        hhht  = "192.168.4.0/24"  # cn-huhehaote     northchina-4
        hz    = "192.168.5.0/24"  # cn-hangzhou      eastchina-1
        sh    = "192.168.6.0/24"  # cn-shanghai      eastchina-2
        cd    = "192.168.7.0/24"  # cn-chengdu       southwest-1
        hk    = "192.168.8.0/24"  # cn-hkongkong     HongKong

        tyo   = "192.168.9.0/24"  # ap-northeast-1   Tokyo - Japana
        sg    = "192.168.9.0/24"  # ap-southeast-2   Singapore
        kl    = "192.168.9.0/24"  # ap-southeast-3   Kuala Lumpur - Malaysia
        jk    = "192.168.9.0/24"  # ap-southeast-5   Jakarta - Indonesia
        bom   = "192.168.9.0/24"  # ap-south-1       Bombay - India

        usva  = "192.168.9.0/24"  # us-east-1        Virginia - US
        ussv  = "192.168.9.0/24"  # us-east-1        Silicon Valley - US

        ldn   = "192.168.9.0/24"  # eu-west-1        London - UK 
        ffm   = "192.168.9.0/24"  # eu-central-1     Frankfurt - France 
     
        dxb   = "192.168.9.0/24"  # me-east-1        Dubai - UThe United Arab EmiratesK
    }
}



/* =====================================================OOS运维编排============================================================= */




/* =====================================================云SSO=================================================================== */



/* 云sso中的账号访问关系数据 账号(key)、用户（组）、权限 */
variable "sso_access_relation_name" {
  type = map(object({
    sso_relation_name      = string
    description     = string
    deploy_user_group = list(object({
      target_type      = string
      target_name      = string
      deploy_access_list = list(string)
    }))
  }))

  default = {
    NSB-Security = {
        sso_relation_name      = "NSB-Security-Rule"
        description     = "NSB-Security 账号下的权限分配"
        deploy_user_group = [
          {
             target_type      = "User"
             target_name      = "fandongfang"
             deploy_access_list = ["SecurityAdmin"]
          },
          {
             target_type      = "Group"
             target_name      = "NSB-Security"
             deploy_access_list = ["SecurityAdmin"]
          }]
   }   
       NSB-DO = {
        sso_relation_name      = "NSB-DO-Rule"
        description     = "NSB-DO 账号下的权限分配"
        deploy_user_group = [
          {
             target_type      = "User"
             target_name      = "fandongfang"
             deploy_access_list = ["Administrator"]
          }]
   }       
  }
}


/* 云sso中的访问配置 */
variable "sso_access" {
  type = map(object({
    sso_access_name      = string
    description     = string
    system_policy_list = list(string)
    custom_policy = optional(string)
  }))

  default = {
    Administrator = {
      sso_access_name      = "Administrator"
      description     = "负责账号下的所有权限"
      system_policy_list = ["AdministratorAccess"]
   }
    FinaceAdmin = {
      sso_access_name      = "FinaceAdmin"
      description     = "负责管理企业财务 （账单 付款 发票等），由NSB-DO-Admin团队中部分核心成员扮演"
      system_policy_list = ["AliyunBSSFullAccess",
                    "AliyunFinanceConsoleFullAccess",
                    "AliyunCloudCommunicationFullAccess"]
   }
    NetworkAdmin = {
      sso_access_name      = "NetworkAdmin"
      description     = "负责基础设施网络的运维，由 NSB-DO-Network团队人员扮演"
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
      sso_access_name      = "DevOpsAdmin"
      description     = "负责应用上云实施，由 NSB-DO-DevOps 团队成员扮演"
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
      sso_access_name      = "SecurityAdmin"
      description     = "负责管理企业财务 （账单 付款 发票等），由NSB-DO-Admin团队中部分核心成员扮演"
      system_policy_list = ["AliyunActionTrailFullAccess",
                            "AliyunConfigFullAccess",
                            "AliyunLogFullAccess",
                            "AliyunOSSFullAccess",
                            "ReadOnlyAccess",
                            "AliyunBSSFullAccess"]
   }
    LogAdmin = {
      sso_access_name      = "LogAdmin"
      description     = "负责组织下所有账号的日志采集分析工作"
      system_policy_list = ["AliyunLogFullAccess",
                            "ReadOnlyAccess"]
   }
    BillingAdmin = {
      sso_access_name      = "BillingAdmin"
      description     = "为兼容目前的老账号，负责管理企业财务 （账单 付款 发票等），由NSB-DO-Admin团队中部分核心成员扮演"
      system_policy_list = ["AliyunBSSFullAccess",
                    "AliyunFinanceConsoleFullAccess",
                    "AliyunCloudCommunicationFullAccess"]
   }
    ResourceUser = {
      sso_access_name      = "ResourceUser"
      description     = "应用部门只读权限"
      system_policy_list = ["ReadOnlyAccess"]
      custom_policy = <<EOF
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