@description('The name of the function app')
param name string

@description('The location where the function app will be created')
param location string

@description('The name of the resource group where the function app will be deployed')
param resourceGroupName string

@description('The ID of the app service plan')
param appServicePlanId string

@description('The name of the storage account to be used by the function app')
param storageAccountName string

@description('The .NET version for the function app')
param dotnetVersion string

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  resourceGroupName: resourceGroupName
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
      netFrameworkVersion: dotnetVersion // For .NET Framework
      linuxFxVersion: dotnetVersion  // For .NET Core/5/6 etc., e.g., "DOTNETCORE|3.1"
    }
  }
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
}

output name string = functionApp.name
output defaultHostName string = functionApp.properties.defaultHostName
