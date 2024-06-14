param storageAccountName string
param vnetName string
param firewallName string
param gatewayName string
param appGatewayName string
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
    firewallSubnetId: virtualNetworkModule.outputs.firewallSubnetId
  }
}

module virtualNetworkGatewayModule 'modules/virtualNetworkGatewayModule.bicep' = {
  name: 'virtualNetworkGatewayDeployment'
  params: {
    gatewayName: gatewayName
    location: location
    gatewaySubnetId: virtualNetworkModule.outputs.gatewaySubnetId
    publicIpName: '${gatewayName}-pip'
  }
}

module applicationGatewayModule 'modules/applicationGatewayModule.bicep' = {
  name: 'applicationGatewayDeployment'
  params: {
    appGatewayName: appGatewayName
    location: location
    vnetId: virtualNetworkModule.outputs.vnetId
    appGatewaySubnetId: virtualNetworkModule.outputs.appGatewaySubnetId
    publicIpName: '${appGatewayName}-pip'
  }
}

output storageAccountId string = storageAccountModule.outputs.storageAccountId
output storageAccountPrimaryEndpoint string = storageAccountModule.outputs.storageAccountPrimaryEndpoint
output vnetId string = virtualNetworkModule.outputs.vnetId
output subnetId string = virtualNetworkModule.outputs.subnetId
output firewallSubnetId string = virtualNetworkModule.outputs.firewallSubnetId
output gatewaySubnetId string = virtualNetworkModule.outputs.gatewaySubnetId
output appGatewaySubnetId string = applicationGatewayModule.outputs.appGatewaySubnetId
output firewallId string = azureFirewallModule.outputs.firewallId
output firewallPublicIPId string = azureFirewallModule.outputs.publicIPId
output gatewayId string = virtualNetworkGatewayModule.outputs.gatewayId
output gatewayPublicIPId string = virtualNetworkGatewayModule.outputs.publicIPId
output appGatewayId string = applicationGatewayModule.outputs.appGatewayId
output appGatewayPublicIPId string = applicationGatewayModule.outputs.publicIPId
