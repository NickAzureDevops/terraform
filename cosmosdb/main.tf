

resource "azapi_update_resource" "test" {
  type        = "Microsoft.DocumentDB/databaseAccounts@2022-05-15"
  resource_id = azurerm_cosmosdb_account.cosmosdbtest120.id
 
  body = jsonencode({
    properties = {
        backupPolicy = {
            type = "Continuous"
                }
           }
        }   
  )
}
