@description('The name of the storage account')
param name string

@description('The location where the storage account will be created')
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output name string = storageAccount.name
output primaryEndpoints object = storageAccount.properties.primaryEndpoints
