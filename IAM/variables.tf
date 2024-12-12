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
      manager_folder = [
        {
          folder = [
            {
              name = "Marketing"
              folder = [
                { name = "prd" },
                { name = "sit" },
                { name = "dev" }
              ]
            },
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
