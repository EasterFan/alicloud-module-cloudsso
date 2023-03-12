terraform {
  required_providers {
    alicloud = {
      source = "alicloud"
    }
  }
}

provider "alicloud" {
  access_key = "LTAI5tJptEE1EL94w8xG1qSB"
  secret_key = "a89REYYYNCdvMU2xYKSBNZgaMCIQkL"
  region     = "cn-hangzhou"
}


variable "oos_repair"{
  type = object({
    machine_region  = string
    tag_key = string
    tag_value = string
  })
  default = { 
	  machine_region = "cn-shanghai", 
    tag_key = "wtest", 
    tag_value = "wtest" }
}

/* variable "oos_baseline"{
  type = object({
    approve_after_days  = string
    tag_key = string
    tag_value = string
  })
  default = { 
	  approve_after_days = "6", 
    tag_key = "wtest", 
    tag_value = "wtest" }
} */


/* 创建补丁基线 */
/* resource "alicloud_oos_patch_baseline" "example" {
  approval_rules      = "{\"PatchRules\":[{\"ApproveAfterDays\":${var.oos_baseline.approve_after_days},\"ComplianceLevel\":\"Unspecified\",\"PatchFilterGroup\":[{\"Key\":\"PatchSet\",\"Values\":[\"OS\"]},{\"Key\":\"ProductFamily\",\"Values\":[[\"Windows\"]]},{\"Key\":\"Product\",\"Values\":[\"*\"]},{\"Key\":\"Classification\",\"Values\":[\"*\"]},{\"Key\":\"Severity\",\"Values\":[\"*\"]}]},{\"ApproveAfterDays\":6,\"ComplianceLevel\":\"Unspecified\",\"PatchFilterGroup\":[{\"Key\":\"PatchSet\",\"Values\":[\"Application\"]},{\"Key\":\"ProductFamily\",\"Values\":[\"ASP.NET Web and Data Frameworks\"]},{\"Key\":\"Product\",\"Values\":[\"ASP.NET Web Frameworks\"]},{\"Key\":\"Classification\",\"Values\":[\"Feature Packs\"]},{\"Key\":\"Severity\",\"Values\":[\"Moderate\"]}]}]}"
  operation_system    = "Windows"
  patch_baseline_name = "my-PatchBaseline"
} */


/* 立即修复 */
resource "alicloud_oos_execution" "repair_now2" {
  template_name = "ACS-ECS-BulkyApplyPatchBaseline"
  description   = "Repair now"  
  /* {"Parameters":"{\"regionId\":\"cn-shanghai\",\"OOSAssumeRole\":\"\",\"action\":\"install\",\"rebootIfNeed\":false,\"targets\":{\"Type\":\"Tags\",\"RegionId\":\"cn-shanghai\",\"Tags\":[{\"Key\":\"wtest\",\"Value\":\"wtest\"}]},\"rateControl\":{\"Mode\":\"Concurrency\",\"Concurrency\":1,\"MaxErrors\":0}}","Mode":"Automatic"} */
  /* parameters    = "{\"regionId\":\"cn-shanghai\",\"OOSAssumeRole\":\"\",\"action\":\"install\",\"rebootIfNeed\":false,\"targets\":{\"Type\":\"Tags\",\"RegionId\":\"cn-shanghai\",\"Tags\":[{\"Key\":\"wtest\",\"Value\":\"wtest\"}]},\"rateControl\":{\"Mode\":\"Concurrency\",\"Concurrency\":1,\"MaxErrors\":0}}"  */
  parameters    = "{\"regionId\":\"${var.oos_repair.machine_region}\",\"OOSAssumeRole\":\"\",\"action\":\"install\",\"rebootIfNeed\":false,\"targets\":{\"Type\":\"Tags\",\"RegionId\":\"${var.oos_repair.machine_region}\",\"Tags\":[{\"Key\":\"${var.oos_repair.tag_key}\",\"Value\":\"${var.oos_repair.tag_value}\"}]},\"rateControl\":{\"Mode\":\"Concurrency\",\"Concurrency\":1,\"MaxErrors\":0}}"                       
}

/* 定时修复 */
resource "alicloud_oos_execution" "repair_at_time3" {
  template_name = "ACS-ECS-BulkyApplyPatchBaseline"
  description   = "Repair at a time"  
  parameters    = "{\"regionId\":\"${var.oos_repair.machine_region}\",\"OOSAssumeRole\":\"OOSServiceRole\",\"action\":\"scan\",\"rebootIfNeed\":false,\"targets\":{\"Type\":\"Tags\",\"RegionId\":\"${var.oos_repair.machine_region}\",\"Tags\":[{\"Key\":\"${var.oos_repair.tag_key}\",\"Value\":\"${var.oos_repair.tag_value}\"}]},\"rateControl\":{\"Mode\":\"Concurrency\",\"Concurrency\":1,\"MaxErrors\":0},\"timerTrigger\":{\"expression\":\"2023-03-09T10:00:00Z\",\"endDate\":\"2999-12-23T09:00:00Z\",\"type\":\"at\"}}"
}
