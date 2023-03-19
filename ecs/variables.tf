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

variable "custom_var" {
  default = ""
}


