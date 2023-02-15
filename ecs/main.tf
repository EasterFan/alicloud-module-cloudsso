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
