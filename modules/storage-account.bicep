@description('The name of the storage account')
param name string

@description('The location where the storage account will be created')
param location string

@description('The name of the resource group where the storage account will be deployed')
param resourceGroupName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: name
  location: location
  resourceGroupName: resourceGroupName
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output name string = storageAccount.name
output primaryEndpoints object = storageAccount.properties.primaryEndpoints
