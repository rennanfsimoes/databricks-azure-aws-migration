provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dbx_rg" {
  name     = "databricks-migration-rg"
  location = "East US"
}

resource "azurerm_databricks_workspace" "source" {
  name                = "dbx-source-azure"
  resource_group_name = azurerm_resource_group.dbx_rg.name
  location            = azurerm_resource_group.dbx_rg.location
  sku                 = "premium"
}
