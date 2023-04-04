resource "alicloud_cms_alarm_contact_group" "contact_group" {
  alarm_contact_group_name = var.contact_group_name
  contacts = [
    alicloud_cms_alarm_contact.first_contact.alarm_contact_name,
    alicloud_cms_alarm_contact.second_contact.alarm_contact_name
  ]
}

resource "alicloud_cms_alarm_contact" "first_contact" {
  alarm_contact_name = "first_contact"
  describe           = "the first contact of the alarm"
  channels_mail      = var.first_contact.mail
  channels_sms       = var.first_contact.sms
  lang               = var.first_contact.lang
}

resource "alicloud_cms_alarm_contact" "second_contact" {
  alarm_contact_name = "second_contact"
  describe           = "the second contact of the alarm"
  channels_mail      = var.second_contact.mail
  channels_sms       = var.second_contact.sms
  lang               = var.second_contact.lang
}
