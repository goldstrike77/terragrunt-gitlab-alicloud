module "alicloud_resource_manager_resource_directory" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-directories?ref=1.x"
  alicloud_resources = var.alicloud_resources
}

module "alicloud_resource_manager_folder" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/folder?ref=1.x"
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_resource_manager_resource_directory]
}
