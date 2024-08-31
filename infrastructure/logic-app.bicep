@description('The name of the Logic App')
param logicAppName string

@description('The location where the Logic App and App Service Plan will be deployed')
param location string = resourceGroup().location

@description('The name of the App Service Plan')
param appServicePlanName string

@description('The pricing tier for the App Service Plan')
param appServicePlanSku string = 'WS1'  // WorkflowStandard Tier 1

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku
    tier: 'WorkflowStandard'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource logicApp 'Microsoft.Web/sites@2020-12-01' = {
  name: logicAppName
  location: location
  kind: 'workflowApp'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~14'
        },
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'node'
        }
      ]
    }
  }
}

output logicAppId string = logicApp.id
