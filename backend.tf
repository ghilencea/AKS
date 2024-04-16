terraform {
  required_version = ">= 1.2.0, < 1.9.0"

  backend "azurerm" {
    storage_account_name = "terraformstateandrei"
    container_name = "terraform"
    key = "terraform.tfstate"
    access_key = ""

    
  }
}

provider "azurerm" {
  features {
    
  }
  subscription_id = "42f0aa72-9941-46be-a162-e863bd1c1caf"
  tenant_id = "6bb41fe4-40a3-4a10-b6cd-38278e78b21a"
}