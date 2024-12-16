generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.237.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
 backend "http" {
 }
}

provider "alicloud" {
  region = "cn-shanghai"
}
EOF
}