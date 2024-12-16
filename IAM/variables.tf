variable "tags" {
  default = {
    location    = "cn-shanghai"
    environment = "prd"
    customer    = "Demo"
    owner       = "Somebody"
    email       = "somebody@mail.com"
    title       = "Engineer"
    department  = "Infra"
  }
}

variable "alicloud_resources" {
  default = [
    {
      resource_directory = [
        {
          status                 = "Enabled"
          member_deletion_status = "Enabled"
        }
      ]
      manager_folder = [
        {
          folder = [
            {
              name = "Infra"
              folder = [
                { name = "Cloud", account = [{ display_name = "cloud" }] },
                { name = "Security", account = [{ display_name = "security" }], policy = ["cp-network"] },
                { name = "Network", account = [{ display_name = "network" }], policy = ["cp-security"] }
              ]
            },
            {
              name = "Business"
              folder = [
                { name = "CustomerService", account = [{ display_name = "cs" }] },
                { name = "Sales", account = [{ display_name = "sales" }] }
              ]
            }
          ]
        }
      ],
      control_policy = [
        {
          control_policy_name = "cp-network"
          policy_document = {
            "Version" : "1",
            "Statement" : [{
              "Effect" : "Allow",
              "Action" : "vpc:*",
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : "vpc:*",
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : "vpc:*",
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : "alb:*",
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : "slb:*",
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : "nlb:*",
              "Resource" : "*"
              }
            ]
          }
        },
        {
          control_policy_name = "cp-security"
          policy_document = {
            "Version" : "1",
            "Statement" : [{
              "Effect" : "Allow",
              "Action" : "yundun-bastionhost:*",
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : [
                "yundun-sas:*",
                "yundun-aegis:*"
              ],
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : [
                "yundun-cloudfirewall:*",
                "yundun-ndr:*"
              ],
              "Resource" : "*"
              }, {
              "Effect" : "Allow",
              "Action" : "yundun-waf:*",
              "Resource" : "*"
              }
            ]
          }
        }
      ],
      ram_role = [
        {
          name = "BillingAdmin",
          policies = [
            "AliyunBSSFullAccess",
            "AliyunFinanceConsoleFullAccess"
          ]
        },
        {
          name = "CloudAdmin"
          policies = [
            "AdministratorAccess"
          ]
        },
        {
          name = "NetworkAdmin"
          policies = [
            "AliyunVPCFullAccess",
            "AliyunNATGatewayFullAccess",
            "AliyunEIPFullAccess",
            "AliyunCENFullAccess",
            "AliyunVPNGatewayFullAccess",
            "AliyunExpressConnectFullAccess",
            "AliyunCommonBandwidthPackageFullAccess",
            "AliyunSmartAccessGatewayFullAccess",
            "AliyunGlobalAccelerationFullAccess",
            "AliyunECSNetworkInterfaceManagementAccess",
            "AliyunDNSFullAccess",
            "AliyunYundunNewBGPAntiDDoSServicePROFullAccess"
          ]
        },
        {
          name = "DBAdmin"
          policies = [
            "AliyunRDSFullAccess",
            "AliyunDRDSFullAccess",
            "AliyunOCSFullAccess",
            "AliyunPolardbFullAccess",
            "AliyunADBFullAccess",
            "AliyunDTSFullAccess",
            "AliyunMongoDBFullAccess",
            "AliyunPetaDataFullAccess",
            "AliyunGPDBFullAccess",
            "AliyunHBaseFullAccess",
            "AliyunYundunDbAuditFullAccess",
            "AliyunHiTSDBFullAccess",
            "AliyunDBSFullAccess",
            "AliyunHDMFullAccess",
            "AliyunGDBFullAccess",
            "AliyunOceanBaseFullAccess",
            "AliyunCassandraFullAccess",
            "AliyunClickHouseFullAccess",
            "AliyunDLAFullAccess"
          ]
        },
        {
          name = "SLBAdmin"
          policies = [
            "AliyunSLBFullAccess",
            "AliyunEIPFullAccess",
            "AliyunECSNetworkInterfaceManagementAccess"
          ]
        },
        {
          name = "CDNAdmin"
          policies = [
            "AliyunCDNFullAccess"
          ]
        },
        {
          name = "MonitorAdmin"
          policies = [
            "AliyunCloudMonitorFullAccess"
          ]
        },
        { name = "MiddlewareAdmin"
          policies = [
            "AliyunKvstoreFullAccess",
            "AliyunMQFullAccess",
            "AliyunElasticsearchFullAccess"
          ]
        }
      ]
    }
  ]
}
