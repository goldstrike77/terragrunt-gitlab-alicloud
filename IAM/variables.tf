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
                { name = "prd" },
                { name = "dev" }
              ]
            },
            {
              name = "Finance"
              folder = [
                { name = "prd" },
                { name = "sit" },
                { name = "dev" }
              ]
            }
          ]
        }
      ]
    }
  ]
}
