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

variable "resource_directory" {
  default = {
    status                 = "Enabled"
    member_deletion_status = "Enabled"
  }
}
