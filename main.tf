# provider "azurerm" {
#     features {

#     }
# }
resource "azurerm_resource_group" "rg1" {
    name =var.rgname
    location =var.location
}

module "ServicePrincipal" {
  source                 = "./modules/ServicePrincipal"
  service_principal_name = var.service_principal_name



  depends_on = [
    azurerm_resource_group.rg1
  ]
}

resource "azurerm_role_assignment" "rolespn" {
    scope                = "/subscriptions/42f0aa72-9941-46be-a162-e863bd1c1caf"
    role_definition_name = "Contributor"
    principal_id         = module.ServicePrincipal.service_principal_object_id
    depends_on = [
        module.ServicePrincipal
    ]
}

module "keyvault"{
    source                 = "./modules/keyvault"
    keyvault_name          = var.keyvault_name
    location               = var.location
    resource_group_name    = var.rgname
    service_principal_name = var.service_principal_name
    service_principal_object_id = module.ServicePrincipal.service_principal_object_id
    service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id
    secret_name = module.ServicePrincipal.client_id
    secret_value = module.ServicePrincipal.client_secret
}




resource "azurerm_key_vault_secret" "example" {
  name         = module.ServicePrincipal.client_id
  value        = module.ServicePrincipal.client_secret
  key_vault_id = module.keyvault.key_vault_id
}

module "aks"{
    source                 = "./modules/aks"
    location               = var.location
    resource_group_name    = var.rgname
    aksAdminObjId = ["6317ca29-9b18-46ef-b3a2-f2972b746e96"]
    aks_name = var.aks_name
}