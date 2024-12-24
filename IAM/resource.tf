# 身份提供商
#module "alicloud_ram_saml_provider" {
#  #source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//ram/ram-saml-provider?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#}

# 用户角色
module "alicloud_ram_role" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//ram/ram-role?ref=1.x"
  alicloud_resources = var.alicloud_resources
}

# 用户
module "alicloud_ram_user" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//ram/ram-user?ref=1.x"
  alicloud_resources = var.alicloud_resources
}
output "alicloud_ram_user_password" {
  value     = module.alicloud_ram_user.alicloud_ram_user_password
  sensitive = true
}

# 用户组
module "alicloud_ram_group" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//ram/ram-group?ref=1.x"
  alicloud_resources = var.alicloud_resources
  depends_on = [
    module.alicloud_ram_role,
    module.alicloud_ram_user
  ]
}

# 启用资源目录
#module "alicloud_resource_manager_resource_directory" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-directories?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#}

# 管控策略
#module "alicloud_resource_manager_control_policy" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/control-policy?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_resource_manager_resource_directory]
#}

# 资源夹
#module "alicloud_resource_manager_folder" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/folder?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_resource_manager_resource_directory]
#}

# 管控策略绑定
#module "alicloud_resource_manager_control_policy_attachment" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/control-policy-attachment?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  depends_on = [
#    module.alicloud_resource_manager_folder,
#    module.alicloud_resource_manager_control_policy
#  ]
#}

# 成员
#module "alicloud_resource_manager_account" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/account?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  tags               = var.tags
#  depends_on         = [module.alicloud_resource_manager_folder]
#}
