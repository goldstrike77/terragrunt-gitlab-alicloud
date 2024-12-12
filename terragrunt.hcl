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
  }
  backend "http" {
    address        = "${get_env("TF_STATE_BASE_ADDRESS")}/${path_relative_to_include()}"
    lock_address   = "${get_env("TF_STATE_BASE_ADDRESS")}/${path_relative_to_include()}/lock"
    unlock_address = "${get_env("TF_STATE_BASE_ADDRESS")}/${path_relative_to_include()}/lock"
  }
}

provider "alicloud" {
  region = "cn-shanghai"
}
EOF
}