terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-devops-rg"
  location = "Central US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "ans-aks-cluster"
  location            = "centralus"
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "ansaksdns"

  sku_tier = "Free"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}