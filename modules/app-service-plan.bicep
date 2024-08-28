@description('The name of the app service plan')
param name string

@description('The location where the app service plan will be created')
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: {
    name: 'P1V2'
    tier: 'PremiumV2'
    capacity: 1
  }
  kind: 'windows'
}

output appServicePlanId string = appServicePlan.id
