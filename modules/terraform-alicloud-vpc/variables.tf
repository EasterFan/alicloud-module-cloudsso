# @reference:
#   https://www.terraform.io/docs/configuration/variables.html
#
# @load order: (later overide earlier)
#   environment variables
#   terraform.tfvars
#   terraform.tfvars.json
#   *.auto.tfvars / *.auto.tfvars.json
#   -var / -var-file
#

variable "access_key" { default = "" }
variable "secret_key" { default = "" }

variable "region" { default = "" }      # takes region id as workspace name
variable "region_abbr" { default = "" } # see: https://github.com/hanyouqing/terraform-alicloud-infra/blob/master/variables.tf#L35

variable "vpc_name" { default = "" }
variable "vpc_description" { default = "" }
variable "vpc_cidr_block" { default = "" } # 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
variable "vpc_availability_zone" { default = "" }
variable "vpc_inner_access_policy" { default = "" }
variable "vpc_whitelist_ips" { default = "" }
variable "vpc_sg_policy_ssh" { default = "" }
variable "vpc_sg_policy_http" { default = "" }
variable "vpc_sg_policy_https" { default = "" }

variable "tags" {
  default = {
    environment = "" # develop|testing|staging|production
    department  = ""
    project     = ""
    service     = ""
    createby    = ""
    owner       = ""
    provisioner = ""
  }
}


variable "region_alias" {
  description = "This variable is just a comment used to save time"
  default = {
    cn-qingdao     = "qd"   # northchina-1
    cn-beijing     = "bj"   # northchina-2
    cn-zhangjiakou = "zjk"  # northchina-3
    cn-huhehaote   = "hhht" # northchina-4
    cn-hangzhou    = "hz"   # eastchina-1
    cn-shanghai    = "sh"   # eastchina-2
    cn-chengdu     = "cd"   # southwest-1
    cn-hkongkong   = "hk"   # HongKong
    ap-northeast-1 = "tyo"  # Tokyo
    ap-southeast-2 = "sg"   # Singapore
    ap-southeast-3 = "kl"   # Kuala
    ap-southeast-5 = "jk"   # Jakarta
    ap-south-1     = "bom"  # Bombay
    us-east-1      = "usva" # Virginia
    us-east-1      = "ussv" # Silicon
    eu-west-1      = "ldn"  # London
    eu-central-1   = "ffm"  # Frankfurt
    me-east-1      = "dxb"  # Dubai
  }
}

variable "cidr_blocks" {
  description = "10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16"
  default = {
    qd   = "192.168.1.0/24" # cn-qingdao       northchina-1
    bj   = "192.168.2.0/24" # cn-beijing       northchina-2
    zjk  = "192.168.3.0/24" # cn-zhangjiakou   northchina-3
    hhht = "192.168.4.0/24" # cn-huhehaote     northchina-4
    hz   = "192.168.5.0/24" # cn-hangzhou      eastchina-1
    sh   = "192.168.6.0/24" # cn-shanghai      eastchina-2
    cd   = "192.168.7.0/24" # cn-chengdu       southwest-1
    hk   = "192.168.8.0/24" # cn-hkongkong     HongKong

    tyo = "192.168.9.0/24" # ap-northeast-1   Tokyo - Japana
    sg  = "192.168.9.0/24" # ap-southeast-2   Singapore
    kl  = "192.168.9.0/24" # ap-southeast-3   Kuala Lumpur - Malaysia
    jk  = "192.168.9.0/24" # ap-southeast-5   Jakarta - Indonesia
    bom = "192.168.9.0/24" # ap-south-1       Bombay - India

    usva = "192.168.9.0/24" # us-east-1        Virginia - US
    ussv = "192.168.9.0/24" # us-east-1        Silicon Valley - US

    ldn = "192.168.9.0/24" # eu-west-1        London - UK 
    ffm = "192.168.9.0/24" # eu-central-1     Frankfurt - France 

    dxb = "192.168.9.0/24" # me-east-1        Dubai - UThe United Arab EmiratesK
  }
}

variable "motd" {
  default = [
    "+++++++++++++++++++++++++++++++++++++++++++++++++++++",
    "+                                                   +",
    "+   The motd is just a advertisement.               +",
    "+   I'm sorry about that, but we really need you.   +",
    "+   Please let me know if you are interested.       +",
    "+                                                   +",
    "+                              Thanks for support!  +",
    "+                         by ihanyouqing@gmail.com  +",
    "+                                                   +",
    "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
  ]
}

