generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
    required_providers {
        alicloud = {
            source = "hashicorp/alicloud"
            version = "1.262.0"
        }
        time = {
            source = "hashicorp/time"
            version = "0.13.1"
        }
        random = {
            source = "hashicorp/random"
            version = "3.7.2"
        }
    }
    backend "oss" {
        bucket = "terraform-remote-backends"
            prefix = "terragrunt-gitlab-alicloud"
            key = "${path_relative_to_include()}/terraform.tfstate"
            acl = "private"
            region = "cn-shanghai"
            encrypt = "false"
    }

}

provider "alicloud" {
  region = "${basename(get_terragrunt_dir())}"
}
EOF
}