// account id for alarm setup, like 1506649656572850
variable "target_account_id" {
  description = "Target account id"
  type        = string
}

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

variable "first_contact" {
  type = object({
    mail = string
    sms  = string
    lang = string
  })
  default = {
    mail = "test_aliyun_alarm_1@test.com"
    sms  = "12388888888"
    lang = "zh-cn"
  }
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
