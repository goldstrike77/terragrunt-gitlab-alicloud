variable "tags" {
  default = {
    location    = "cn-shanghai"
    environment = "prd"
    customer    = "demo"
    owner       = "somebody"
    email       = "somebody@mail.com"
    title       = "Engineer"
    department  = "DevOps"
  }
}

variable "alicloud_resources" {
  default = [
    {
      resource_manager_resource_group = {
        name = "rg-p-shared-audit-001"
      }
      actiontrail_trail = [
        {
          trail_name            = "action-trail"
          event_rw              = "All"
          sls_project           = "p-shared-actiontrail-1013fgoi"
          oss_bucket_name       = "p-shared-actiontrail-001-ywhmyp5y"
          is_organization_trail = true
        }
      ]
      log_project = [
        {
          name = "p-shared-actiontrail-1013fgoi"
        }
      ]
      oss_bucket = [
        {
          bucket = "p-shared-actiontrail-001-ywhmyp5y"
          force_destroy = true
          lifecycle_rule = {
            enabled = true
            expiration = {
              days = 180
            }
          }
        }
      ]
    }
  ]
}
