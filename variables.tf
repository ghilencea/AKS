variable "rgname" {
    type =string
    description ="resource group name"
}

variable "location" {
    type =string
    default ="canadacentral"
}
variable "service_principal_name" {
    type =string
    default ="aks_spn"
}

variable "keyvault_name" {
    type =string
}

variable "aks_name" {
  type = string
}