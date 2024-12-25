variable "tags" {
  default = {
    location    = "eastasia"
    environment = "prd"
    customer    = "Learn"
    owner       = "Somebody"
    email       = "somebody@mail.com"
    title       = "Engineer"
    department  = "IS"
  }
}

variable "alicloud_resources" {
  default = [
    {
      resource_manager_resource_group = {
        name = "rg-p-network-transit-001"
      }
      security_group = [
        {
          vpc_name            = "vpc-p-network-transit-cn-shanghai-001"
          security_group_name = "sg-p-transit-bastion-cn-shanghai-001"
        }
      ],
      vpc = [
        {
          vpc_name             = "vpc-p-network-transit-cn-shanghai-001"
          tags                 = {}
          cidr_block           = "10.30.0.0/16"
          secondary_cidr_block = ["10.31.0.0/16", "10.32.0.0/16"]
          route_table = [
            {
              route_entry = [
                {
                  destination_cidrblock = "10.40.0.0/16"
                  nexthop_type          = "VpcPeer"
                  nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-devops-cn-shanghai-001"
                },
                {
                  destination_cidrblock = "10.43.0.0/16"
                  nexthop_type          = "VpcPeer"
                  nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-toolchain-cn-shanghai-001"
                }
              ]
            }
          ]
          vpc_peer_connection = [
            {
              accepting_vpc       = "vpc-p-network-devops-cn-shanghai-001"
              accepting_region_id = "cn-shanghai"
              accepting_ali_uid   = "1735232106839245"
            },
            {
              accepting_vpc       = "vpc-p-network-toolchain-cn-shanghai-001"
              accepting_region_id = "cn-shanghai"
              accepting_ali_uid   = "1735232106839245"
            }
          ]
          vswitch = [
            {
              vswitch_name = "vsw-p-network-transit-ngw-cn-shanghai-001"
              cidr_block   = "10.30.0.0/26"
              zone_id      = "cn-shanghai-b"
            },
            {
              vswitch_name = "vsw-p-network-transit-bastion-cn-shanghai-001"
              cidr_block   = "10.30.0.64/26"
              zone_id      = "cn-shanghai-b"
            },
            {
              vswitch_name = "vsw-p-network-transit-vpn-cn-shanghai-001"
              cidr_block   = "10.30.0.128/26"
              zone_id      = "cn-shanghai-b"
            },
            {
              vswitch_name = "vsw-p-network-transit-vpn-cn-shanghai-002"
              cidr_block   = "10.30.0.192/26"
              zone_id      = "cn-shanghai-a"
            },
            {
              vswitch_name = "vsw-p-network-transit-alb-cn-shanghai-001"
              cidr_block   = "10.30.1.0/26"
              zone_id      = "cn-shanghai-m"
            },
            {
              vswitch_name = "vsw-p-network-transit-alb-cn-shanghai-002"
              cidr_block   = "10.30.1.64/26"
              zone_id      = "cn-shanghai-n"
            }
          ]
        }
      ],
      nat_gateway = [
        {
          vpc_name         = "vpc-p-network-transit-cn-shanghai-001"
          vswitch_name     = "vsw-p-network-transit-ngw-cn-shanghai-001"
          nat_gateway_name = "ngw-p-shared-transit-cn-shanghai-001"
        }
      ],
      eip = [
        {
          address_name  = "eip-ngw-p-shared-transit-cn-shanghai-001"
          instance_type = "NAT"
          instance_name = "ngw-p-shared-transit-cn-shanghai-001"
        }
      ],
      snat_entry = [
        {
          nat_gateway_name = "ngw-p-shared-transit-cn-shanghai-001"
          eip_address_name = "eip-ngw-p-shared-transit-cn-shanghai-001"
          source_cidr      = "10.0.0.0/8"
        }
      ],
      vpn_gateway = [
        {
          vpc_name                       = "vpc-p-network-transit-cn-shanghai-001"
          vswitch_name                   = "vsw-p-network-transit-vpn-cn-shanghai-001"
          disaster_recovery_vswitch_name = "vsw-p-network-transit-vpn-cn-shanghai-002"
          vpn_gateway_name               = "vgw-p-shared-transit-cn-shanghai-001"
          enable_ipsec                   = false
          enable_ssl                     = true
          ssl_vpn_server = [
            {
              name           = "ssl-vgw-p-shared-transit-cn-shanghai-001"
              client_ip_pool = "192.168.2.0/24"
              ssl_vpn_client_cert = [
                {
                  name = "cert-ssl-vgw-p-shared-transit-cn-shanghai-001"
                }
              ]
            }
          ]
        }
      ],
      alb_load_balancer = [
        {
          vpc_name           = "vpc-p-network-transit-cn-shanghai-001"
          vswitch_name       = ["vsw-p-network-transit-alb-cn-shanghai-001", "vsw-p-network-transit-alb-cn-shanghai-002"]
          load_balancer_name = "alb-p-shared-transit-cn-shanghai-001"
        }
      ]
    },
    {
      resource_manager_resource_group = {
        name = "rg-p-network-devops-001"
      }
      security_group = [
        {
          vpc_name            = "vpc-p-network-devops-cn-shanghai-001"
          security_group_name = "sg-p-devops-ecs-cn-shanghai-001"
          rule = [
            { type = "ingress", ip_protocol = "tcp", port_range = "22/22", nic_type = "intranet", policy = "accept", priority = 10, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "80/80", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "443/443", nic_type = "intranet", policy = "accept", priority = 30, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "3389/3389", nic_type = "intranet", policy = "accept", priority = 40, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
          ]
        },
        {
          vpc_name            = "vpc-p-network-devops-cn-shanghai-001"
          security_group_name = "sg-p-devops-ack-cn-shanghai-001"
          rule = [
            { type = "ingress", ip_protocol = "tcp", port_range = "80/80", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "443/443", nic_type = "intranet", policy = "accept", priority = 30, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
          ]
        },
        {
          vpc_name            = "vpc-p-network-toolchain-cn-shanghai-001"
          security_group_name = "sg-p-toolchain-ecs-cn-shanghai-001"
          rule = [
            { type = "ingress", ip_protocol = "tcp", port_range = "22/22", nic_type = "intranet", policy = "accept", priority = 10, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "80/80", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "443/443", nic_type = "intranet", policy = "accept", priority = 30, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "3389/3389", nic_type = "intranet", policy = "accept", priority = 40, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
          ]
        },
        {
          vpc_name            = "vpc-p-network-toolchain-cn-shanghai-001"
          security_group_name = "sg-p-toolchain-kvstore-cn-shanghai-001"
          rule = [
            { type = "ingress", ip_protocol = "tcp", port_range = "6379/6379", nic_type = "intranet", policy = "accept", priority = 10, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "tcp", port_range = "11211/11211", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
            { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
          ]
        }
      ],
      vpc = [
        {
          vpc_name             = "vpc-p-network-devops-cn-shanghai-001"
          tags                 = {}
          cidr_block           = "10.40.0.0/16"
          secondary_cidr_block = ["10.41.0.0/16", "10.42.0.0/16"]
          route_table = [
            {
              route_entry = [
                {
                  destination_cidrblock = "0.0.0.0/0"
                  nexthop_type          = "VpcPeer"
                  nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-devops-cn-shanghai-001"
                }
              ]
            }
          ]
          vswitch = [
            {
              vswitch_name = "vsw-p-network-devops-ack-cn-shanghai-001"
              cidr_block   = "10.40.0.0/22"
              zone_id      = "cn-shanghai-f"
            },
            {
              vswitch_name = "vsw-p-network-devops-ack-cn-shanghai-002"
              cidr_block   = "10.40.4.0/22"
              zone_id      = "cn-shanghai-f"
            },
            {
              vswitch_name = "vsw-p-network-devops-ecs-cn-shanghai-001"
              cidr_block   = "10.40.8.0/22"
              zone_id      = "cn-shanghai-f"
            },
            {
              vswitch_name = "vsw-p-network-devops-rds-cn-shanghai-001"
              cidr_block   = "10.40.12.0/22"
              zone_id      = "cn-shanghai-f"
            }
          ]
        },
        {
          vpc_name             = "vpc-p-network-toolchain-cn-shanghai-001"
          tags                 = {}
          cidr_block           = "10.43.0.0/16"
          secondary_cidr_block = ["10.44.0.0/16", "10.45.0.0/16"]
          route_table = [
            {
              route_entry = [
                {
                  destination_cidrblock = "0.0.0.0/0"
                  nexthop_type          = "VpcPeer"
                  nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-toolchain-cn-shanghai-001"
                }
              ]
            }
          ]
          vswitch = [
            {
              vswitch_name = "vsw-p-network-toolchain-ecs-cn-shanghai-001"
              cidr_block   = "10.43.0.0/22"
              zone_id      = "cn-shanghai-f"
            }
          ]
        }
      ]
    }
  ]
}
