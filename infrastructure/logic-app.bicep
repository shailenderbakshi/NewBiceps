@description('The name of the Logic App')
param logicAppName string

@description('The location where the Logic App and Application Insights will be deployed')
param location string = resourceGroup().location

@description('The pricing tier for the Logic App')
param logicAppSku string = 'Standard'  // Other options: Consumption, etc.

@description('The name of the Application Insights resource')
param appInsightsName string

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  properties: {
    definition: {
      "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
      contentVersion: "1.0.0.0",
      actions: {},
      triggers: {}
    }
    integrationAccount: null
    state: 'Enabled'
  }
  sku: {
    name: logicAppSku
  }
  tags: {
    'hidden-link:/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Insights/components/${appInsights.name}': 'Resource'
  }
}

output logicAppId string = logicApp.id
output appInsightsId string = appInsights.id
