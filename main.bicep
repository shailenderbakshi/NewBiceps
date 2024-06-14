param storageAccountName string
param location string = resourceGroup().location

module storageAccountModule 'modules/storageAccountModule.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

output storageAccountId string = storageAccountModule.outputs.storageAccountId
output storageAccountPrimaryEndpoint string = storageAccountModule.outputs.storageAccountPrimaryEndpoint
