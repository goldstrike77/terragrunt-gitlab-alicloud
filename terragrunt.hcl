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
}

provider "alicloud" {
  region = "cn-shanghai"
}
EOF
}