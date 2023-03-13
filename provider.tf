terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.43.0"
    }
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.6.0"
    }
  }
}

provider "azurerm" {
  features {}
}
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.demodb.id
}
