param location string = 'West Europe'
param storageAccountName string
param functionAppName string
param appServicePlanName string = 'function-app-service-plan'
param dotnetVersion string = 'v4.0'  // For .NET Framework, use "v6.0" for .NET 6
param resourceGroupName string

// Deploy Storage Account
module storageAccountModule './modules/storage-account.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    name: storageAccountName
    location: location
    resourceGroupName: resourceGroupName
  }
}

// Deploy App Service Plan
module appServicePlanModule './modules/app-service-plan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    name: appServicePlanName
    location: location
    resourceGroupName: resourceGroupName
  }
}

// Deploy Function App
module functionAppModule './modules/function-app.bicep' = {
  name: 'functionAppDeployment'
  params: {
    name: functionAppName
    location: location
    resourceGroupName: resourceGroupName
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
    storageAccountName: storageAccountModule.outputs.name
    dotnetVersion: dotnetVersion
  }
}
