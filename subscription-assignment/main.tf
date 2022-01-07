terraform {
    required_providers {
        azurerm = {
            version = "~>2.0"
            source = "azurerm"
        }
    }
}

provider "azurerm" {
    features {}
}