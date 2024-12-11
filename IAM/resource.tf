module "alicloud_resource_manager_resource_directory" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-directories?ref=1.x"
  resource_directory = var.resource_directory
}
