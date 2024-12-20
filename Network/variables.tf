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
                  #nexthop_type          = "VpcPeer"
                  #nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-devops-cn-shanghai-001"
                },
                {
                  destination_cidrblock = "10.43.0.0/16"
                  #nexthop_type          = "VpcPeer"
                  #nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-toolchain-cn-shanghai-001"
                }
              ]
            }
          ]
          vpc_peer_connection = [
            {
              accepting_vpc       = "vpc-p-network-devops-cn-shanghai-001"
              accepting_region_id = "cn-shanghai"
              accepting_ali_uid   = "5993134423372267"
            },
            {
              accepting_vpc       = "vpc-p-network-toolchain-cn-shanghai-001"
              accepting_region_id = "cn-shanghai"
              accepting_ali_uid   = "5993134423372267"
            }
          ]
          vswitch = [
            {
              vswitch_name = "vsw-p-network-transit-ngw-cn-shanghai-001"
              cidr_block   = "10.30.0.0/26"
              zone_id      = "cn-shanghai-b"
              nat_gateway = [
                {
                  nat_gateway_name = "ngw-p-shared-transit-cn-shanghai-001"
                }
              ]
            },
            {
              vswitch_name = "vsw-p-network-transit-bastion-cn-shanghai-001"
              cidr_block   = "10.30.0.64/26"
              zone_id      = "cn-shanghai-b"
            }
          ]
          security_group = [
            {
              name = "sg-p-transit-bastion-cn-shanghai-001"
            }
          ]
        }
      ]
    },
    {
      resource_manager_resource_group = {
        name = "rg-p-network-devops-001"
      }
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
                  #nexthop_type          = "VpcPeer"
                  #nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-devops-cn-shanghai-001"
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
          security_group = [
            {
              name = "sg-p-devops-ecs-cn-shanghai-001"
              rule = [
                { type = "ingress", ip_protocol = "tcp", port_range = "22/22", nic_type = "intranet", policy = "accept", priority = 10, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "80/80", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "443/443", nic_type = "intranet", policy = "accept", priority = 30, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "3389/3389", nic_type = "intranet", policy = "accept", priority = 40, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
              ]
            },
            {
              name = "sg-p-devops-ack-cn-shanghai-001"
              rule = [
                { type = "ingress", ip_protocol = "tcp", port_range = "80/80", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "443/443", nic_type = "intranet", policy = "accept", priority = 30, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
              ]
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
                  #nexthop_type          = "VpcPeer"
                  #nexthop               = "pcc-vpc-p-network-transit-cn-shanghai-001-peer-vpc-p-network-toolchain-cn-shanghai-001"
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
          security_group = [
            {
              name = "sg-p-toolchain-ecs-cn-shanghai-001"
              rule = [
                { type = "ingress", ip_protocol = "tcp", port_range = "22/22", nic_type = "intranet", policy = "accept", priority = 10, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "80/80", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "443/443", nic_type = "intranet", policy = "accept", priority = 30, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "3389/3389", nic_type = "intranet", policy = "accept", priority = 40, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
              ]
            },
            {
              name = "sg-p-toolchain-kvstore-cn-shanghai-001"
              rule = [
                { type = "ingress", ip_protocol = "tcp", port_range = "6379/6379", nic_type = "intranet", policy = "accept", priority = 10, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "tcp", port_range = "11211/11211", nic_type = "intranet", policy = "accept", priority = 20, cidr_ip = "0.0.0.0/0" },
                { type = "ingress", ip_protocol = "icmp", priority = 50, cidr_ip = "0.0.0.0/0" }
              ]
            }
          ]
        }
      ]
    }
  ]
}