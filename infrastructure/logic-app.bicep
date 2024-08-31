@description('The name of the Logic App')
param logicAppName string

@description('The location where the Logic App will be deployed')
param location string = resourceGroup().location

@description('The pricing tier for the Logic App')
param logicAppSku string = 'Standard'

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  properties: {
    definition: {
      contentVersion: '1.0.0.0',
      actions: {},
      triggers: {}
    }
    integrationAccount: null
    state: 'Enabled'
  }
  sku: {
    name: logicAppSku
  }
}

output logicAppId string = logicApp.id
