@description('The name of the app service plan')
param name string

@description('The location where the app service plan will be created')
param location string

@description('The name of the resource group where the app service plan will be deployed')
param resourceGroupName string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  resourceGroupName: resourceGroupName
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  kind: 'functionapp'
}

output appServicePlanId string = appServicePlan.id
