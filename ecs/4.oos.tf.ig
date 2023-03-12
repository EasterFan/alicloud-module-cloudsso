



variable "oos"{
  type = object({
    oos_region  = string
    tag_key = string
    tag_value = string
  })
  default = { 
	oos_region = "cn-shanghai", 
    tag_key = "wtest", 
    tag_value = "wtest" }
}


/* 
resource "alicloud_oos_patch_baseline" "example" {
  approval_rules      = "example_value"
  operation_system    = "Windows"
  patch_baseline_name = "my-PatchBaseline"
} */



resource "alicloud_oos_execution" "repair_now" {
  template_name = "ACS-ECS-BulkyApplyPatchBaseline"
  description   = "Repair now"  
  /* parameters    = "{\"regionId\":\"cn-shanghai\",\"OOSAssumeRole\":\"\",\"action\":\"install\",\"rebootIfNeed\":false,\"targets\":{\"Type\":\"Tags\",\"RegionId\":\"cn-shanghai\",\"Tags\":[{\"Key\":\"wtest\",\"Value\":\"wtest\"}]},\"rateControl\":{\"Mode\":\"Concurrency\",\"Concurrency\":1,\"MaxErrors\":0}}"  */
  parameters    = "{\"regionId\":\"cn-shanghai\",\"OOSAssumeRole\":\"\",\"action\":\"install\",\"rebootIfNeed\":false,\"targets\":{\"Type\":\"Tags\",\"RegionId\":\"cn-shanghai\",\"Tags\":[{\"Key\":\"${var.oos.tag_key}\",\"Value\":\"${var.oos.tag_value}\"}]},\"rateControl\":{\"Mode\":\"Concurrency\",\"Concurrency\":1,\"MaxErrors\":0}}"                       
}