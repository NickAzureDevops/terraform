#$RESOURCE_GROUP_NAME='terraform-learning'
#$STORAGE_ACCOUNT_NAME="saterraformdevops"
#$CONTAINER_NAME='tfstate'

# Create resource group
#New-AzResourceGroup -Name $RESOURCE_GROUP_NAME -Location UKSouth

# Create storage account
#$storageAccount = New-AzStorageAccount -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME -SkuName Standard_LRS -Location eastus -AllowBlobPublicAccess $true

# Create blob container
#New-AzStorageContainer -Name $CONTAINER_NAME -Context $storageAccount.context -Permission blob

provider "azurerm" {
    version = "~> 2.0"
    features {}
}

