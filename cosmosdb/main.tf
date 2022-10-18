resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-rg"
  location = var.location
}


resource "azapi_update_resource" "test" {
  type        = "Microsoft.DocumentDB/databaseAccounts@2022-05-15-preview"
  resource_id = azurerm_cosmosdb_account.test.id

  body = jsonencode({
    properties = {
      backupPolicy = {
        type = "Continuous",
        continuousModeProperties : {
          tier : "Continuous30Days"
        }
      }
    }
    }
  )
}


resource "azapi_update_resource" "example" {
  type        = "Microsoft.Network/loadBalancers@2021-03-01"
  resource_id = azurerm_lb.example.id

  body = jsonencode({
    properties = {
      inboundNatRules = [
        {
          properties = {
            idleTimeoutInMinutes = 15
          }
        }
      ]
    }
  })

}