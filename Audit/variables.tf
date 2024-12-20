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
      oss_project = [
        {
          name = "p-shared-logs"
        }
      ]
      oss_bucket = [
        {
          bucket = "p-shared-logs-001"
        }
      ]
    }
  ]
}
