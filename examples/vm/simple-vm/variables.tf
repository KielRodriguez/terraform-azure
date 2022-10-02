variable "project_name" {
  type    = string
  default = "az-examples"

  description = <<EOT
    Default: az-examples

    Project name variable
    EOT

}

variable "location" {
  type    = string
  default = "East US 2"

  description = <<EOT
    Default: East US 2

    Location where project wil be located
    EOT
}

variable "rg_name" {
  type        = string
  description = <<EOT
    
    [Required] Resource group name where the vnet will be deployed

    EOT
}

variable "subnet_id" {
  type = string

  description = <<EOT
  [Required] Subnet id where the VM will be deployed
  EOT
}