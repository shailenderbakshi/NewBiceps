param storageAccountName string
param vnetName string
param firewallName string
param location string = resourceGroup().location

module storageAccountModule 'modules/storageAccountModule.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

module virtualNetworkModule 'modules/virtualNetworkModule.bicep' = {
  name: 'virtualNetworkDeployment'
  params: {
    vnetName: vnetName
    location: location
  }
}

module azureFirewallModule 'modules/azureFirewallModule.bicep' = {
  name: 'azureFirewallDeployment'
  params: {
    firewallName: firewallName
    location: location
    vnetId: virtualNetworkModule.outputs.vnetId
  }
}

output storageAccountId string = storageAccountModule.outputs.storageAccountId
output storageAccountPrimaryEndpoint string = storageAccountModule.outputs.storageAccountPrimaryEndpoint
output vnetId string = virtualNetworkModule.outputs.vnetId
output subnetId string = virtualNetworkModule.outputs.subnetId
output firewallId string = azureFirewallModule.outputs.firewallId
