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
    backend "s3" {
      bucket = "tfstate"
          key = "tfstate/terragrunt-gitlab-alicloud/${path_relative_to_include()}/terraform.tfstate"
          region = "us-east-1"
          endpoints = {
          s3 = "http://obs.home.local"
      }
      skip_credentials_validation = true
      skip_requesting_account_id = true
      skip_metadata_api_check = true
      skip_region_validation = true
      use_path_style = true
    }
}

provider "alicloud" {
  region = "${basename(get_terragrunt_dir())}"
}
EOF
}