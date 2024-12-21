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
      ],
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
      ram_group = [
        {
          name       = "Cloud",
          user_names = ["jackiechen"]
          policy = [
            { type = "Custom", name = "policy-BillingAdmin" },
            { type = "Custom", name = "policy-CloudAdmin" },
            { type = "Custom", name = "policy-DBAdmin" }
          ]
        },
        {
          name       = "Network",
          user_names = ["jackiechen", "tomzhu"]
          policy = [
            { type = "Custom", name = "policy-NetworkAdmin" },
            { type = "Custom", name = "policy-SLBAdmin" },
            { type = "Custom", name = "policy-CDNAdmin" }
          ]
        }
      ],
      ram_user = [
        {
          name = "jackiechen",
        },
        {
          name = "tomzhu",
        }
      ],
      ram_role = [
        {
          name     = "AADrole",
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Condition" : { "StringEquals" : { "saml:recipient" : "https://signin.aliyun.com/saml-role/sso" } }, "Effect" : "Allow", "Principal" : { "Federated" : ["acs:ram::1735232106839245:saml-provider/AAD"] } }], "Version" : "1" }
          policies = [
            "AliyunLogFullAccess"
          ]
        },
        {
          name     = "BillingAdmin",
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
          policies = [
            "AliyunBSSFullAccess",
            "AliyunFinanceConsoleFullAccess"
          ]
        },
        {
          name     = "CloudAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
          policies = [
            "AdministratorAccess"
          ]
        },
        {
          name     = "NetworkAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
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
          name     = "DBAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
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
          name     = "SLBAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
          policies = [
            "AliyunSLBFullAccess",
            "AliyunEIPFullAccess",
            "AliyunECSNetworkInterfaceManagementAccess"
          ]
        },
        {
          name     = "CDNAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
          policies = [
            "AliyunCDNFullAccess"
          ]
        },
        {
          name     = "MonitorAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
          policies = [
            "AliyunCloudMonitorFullAccess"
          ]
        },
        {
          name     = "MiddlewareAdmin"
          document = { "Statement" : [{ "Action" : "sts:AssumeRole", "Effect" : "Allow", "Principal" : { "RAM" : ["acs:ram::1735232106839245:root"] } }], "Version" : "1" }
          policies = [
            "AliyunKvstoreFullAccess",
            "AliyunMQFullAccess",
            "AliyunElasticsearchFullAccess"
          ]
        }
      ]
      saml_provider = [
        {
          name              = "AAD"
          metadata_document = "./meta_aad.xml"
        }
      ]
    }
  ]
}
