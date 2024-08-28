@description('The name of the function app')
param name string

@description('The location where the function app will be created')
param location string

@description('The ID of the app service plan')
param appServicePlanId string

@description('The name of the storage account to be used by the function app')
param storageAccountName string

@description('The .NET version for the function app')
param dotnetVersion string

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=core.windows.net'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
      netFrameworkVersion: dotnetVersion  // Correctly specifies the .NET version for Windows-based apps
    }
  }
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
}

output name string = functionApp.name
output defaultHostName string = functionApp.properties.defaultHostName
