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

variable "resource_directory" {
  default = {
    status                 = "Enabled"
    member_deletion_status = "Enabled"
  }
}
