variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type      = string
  sensitive = true
}
variable "resource_group_name" {
  description = "Name of the existing Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure location of the existing Resource Group"
  type        = string
}
variable "agent_public_ip" {
  description = "The public IP of the DevOps agent running the pipeline"
  type        = string
}