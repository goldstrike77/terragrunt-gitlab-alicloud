# 资源组
module "alicloud_resource_manager_resource_group" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-group?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
}

# 专有网络
module "alicloud_vpc" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpc?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_resource_manager_resource_group]
}

# 专有网络附加地址
module "alicloud_vpc_ipv4_cidr_block" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpc/ipv4-cidr-block?ref=1.x"
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vpc]
}

# 专有网络对等连接
module "alicloud_vpc_peer_connection" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpc/peer-connection?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vpc]
}

# 交换机
module "alicloud_vswitch" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vswitch?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vpc_ipv4_cidr_block]
}

# 路有表
module "alicloud_route_table" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//route/table?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vswitch, module.alicloud_vpc_peer_connection]
}

# 安全组
module "alicloud_security_group" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//security/group?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vpc]
}

# NAT网关
module "alicloud_nat_gateway" {
  #source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//nat-gateway?ref=1.x"
  source             = "/home/suzhetao/github/terraform/module/terraform-module-alicloud/nat-gateway"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vswitch]
}

# 弹性公网IP
module "alicloud_eip_address" {
  #source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//eip-address?ref=1.x"
  source             = "/home/suzhetao/github/terraform/module/terraform-module-alicloud/eip-address"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_nat_gateway]
}

# SNAT条目
module "alicloud_snat_entry" {
  #source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//snat-entry?ref=1.x"
  source             = "/home/suzhetao/github/terraform/module/terraform-module-alicloud/snat-entry"
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_nat_gateway, module.alicloud_eip_address]
}
