# 资源组
module "alicloud_resource_manager_resource_group" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-group?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
}

# 日志项目
module "alicloud_log_project" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//log/project?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_resource_manager_resource_group]
}

# 存储桶
module "alicloud_oss_bucket" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//oss/bucket?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_resource_manager_resource_group]
}

# 操作审计
module "alicloud_actiontrail_trail" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//actiontrail/trail?ref=1.x"
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_log_project, module.alicloud_oss_bucket]
}
