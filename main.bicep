@description('The location where resources will be created')
param location string = 'East US'

@description('The name of the storage account')
param storageAccountName string

@description('The name of the Function App')
param functionAppName string

@description('The name of the App Service Plan')
param appServicePlanName string = 'function-app-service-plan'

@description('The .NET version for the Function App')
param dotnetVersion string = 'v6.0'  // Use "v6.0" for .NET 6 on Windows

@description('The name of the VNet')
param vnetName string

@description('The name of the subnet within the VNet')
param subnetName string

@description('The address prefix for the VNet')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('The address prefix for the subnet')
param subnetAddressPrefix string = '10.0.0.0/24'

// Deploy Storage Account
module storageAccountModule './modules/storage-account.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    name: storageAccountName
    location: location
  }
}

// Deploy App Service Plan
module appServicePlanModule './modules/app-service-plan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    name: appServicePlanName
    location: location
  }
}

// Deploy Virtual Network and Subnet
module vnetModule './modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: vnetName
    subnetName: subnetName
    vnetAddressPrefix: vnetAddressPrefix
    subnetAddressPrefix: subnetAddressPrefix
    location: location
  }
}

// Deploy Function App with VNet Integration
module functionAppModule './modules/function-app.bicep' = {
  name: 'functionAppDeployment'
  params: {
    name: functionAppName
    location: location
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
    storageAccountName: storageAccountModule.outputs.name
    dotnetVersion: dotnetVersion
    subnetId: vnetModule.outputs.subnetId
  }
}
