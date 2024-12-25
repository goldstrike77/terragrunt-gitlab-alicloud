# 资源组
module "alicloud_resource_manager_resource_group" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//resource-manager/resource-group?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
}

# 专有网络
module "alicloud_vpc" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpc/vpc?ref=1.x"
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
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpc/vswitch?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vpc_ipv4_cidr_block]
}

# 路由表
module "alicloud_route_table" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpc/route-table?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vswitch, module.alicloud_vpc_peer_connection]
}

# 安全组
module "alicloud_security_group" {
  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//ecs/security-group?ref=1.x"
  tags               = var.tags
  alicloud_resources = var.alicloud_resources
  depends_on         = [module.alicloud_vpc]
}

# 公网NAT网关
#module "alicloud_nat_gateway" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//nat-gateway/nat-gateway?ref=1.x"
#  tags               = var.tags
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_vswitch]
#}

# 弹性公网IP
#module "alicloud_eip_address" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//eip/eip-address?ref=1.x"
#  tags               = var.tags
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_nat_gateway]
#}

# SNAT条目
#module "alicloud_snat_entry" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//nat-gateway/snat-entry?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_nat_gateway, module.alicloud_eip_address]
#}

# VPN网关
#module "alicloud_vpn_gateway" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpn-gateway/vpn-gateway?ref=1.x"
#  tags               = var.tags
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_vswitch]
#}

# SSL服务端
#module "alicloud_ssl_vpn_server" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpn-gateway/ssl-vpn-server?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_vpn_gateway]
#}

# SSL客户端证书
#module "alicloud_ssl_vpn_client_cert" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//vpn-gateway/ssl-vpn-client-cert?ref=1.x"
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_ssl_vpn_server]
#}

# 应用型负载均衡
#module "alicloud_alb_load_balancer" {
#  source             = "git::https://gitea.home.local/suzhetao/terraform-module-alicloud.git//alb/alb_load_balancer?ref=1.x"
#  tags               = var.tags
#  alicloud_resources = var.alicloud_resources
#  depends_on         = [module.alicloud_vswitch]
#}
