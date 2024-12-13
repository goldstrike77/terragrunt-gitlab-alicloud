# 管控策略
module "alicloud_resource_manager_account" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/control-policy?ref=1.x"
  alicloud_resources = var.alicloud_resources
}

# 启用资源目录
module "alicloud_resource_manager_resource_directory" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-directories?ref=1.x"
  alicloud_resources = var.alicloud_resources
}

# 资源夹
module "alicloud_resource_manager_folder" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/folder?ref=1.x"
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_resource_manager_resource_directory]
}

# 成员
module "alicloud_resource_manager_account" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/account?ref=1.x"
  alicloud_resources = var.alicloud_resources
  tags               = var.tags
  depends_on         = [module.alicloud_resource_manager_folder]
}
