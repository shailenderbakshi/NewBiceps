// param storageAccountName string
// param vnetName string
// param firewallName string
// param gatewayName string
// param bastionHostName string
// param logAnalyticsWorkspaceName string
// param location string = resourceGroup().location

// module storageAccountModule 'modules/storageAccountModule.bicep' = {
//   name: 'storageAccountDeployment'
//   params: {
//     storageAccountName: storageAccountName
//     location: location
//   }
// }

// module virtualNetworkModule 'modules/virtualNetworkModule.bicep' = {
//   name: 'virtualNetworkDeployment'
//   params: {
//     vnetName: vnetName
//     location: location
//   }
// }

// module azureFirewallModule 'modules/azureFirewallModule.bicep' = {
//   name: 'azureFirewallDeployment'
//   params: {
//     firewallName: firewallName
//     location: location
//     vnetId: virtualNetworkModule.outputs.vnetId
//     firewallSubnetId: virtualNetworkModule.outputs.firewallSubnetId
//   }
// }

// module virtualNetworkGatewayModule 'modules/virtualNetworkGatewayModule.bicep' = {
//   name: 'virtualNetworkGatewayDeployment'
//   params: {
//     gatewayName: gatewayName
//     location: location
//     gatewaySubnetId: virtualNetworkModule.outputs.gatewaySubnetId
//     publicIpName: '${gatewayName}-pip'
//   }
// }

// module bastionHostModule 'modules/bastionHostModule.bicep' = {
//   name: 'bastionHostDeployment'
//   params: {
//     bastionHostName: bastionHostName
//     location: location
//     vnetId: virtualNetworkModule.outputs.vnetId
//     bastionSubnetId: virtualNetworkModule.outputs.bastionSubnetId
//     publicIpName: '${bastionHostName}-pip'
//   }
// }

// module logAnalyticsWorkspaceModule 'modules/logAnalyticsWorkspaceModule.bicep' = {
//   name: 'logAnalyticsWorkspaceDeployment'
//   params: {
//     workspaceName: logAnalyticsWorkspaceName
//     location: location
//   }
// }

module networkWatcherModule 'modules/networkWatcherModule.bicep' = {
  name: 'networkWatcherDeployment'
  params: {
    location: location
  }
}

output storageAccountId string = storageAccountModule.outputs.storageAccountId
output storageAccountPrimaryEndpoint string = storageAccountModule.outputs.storageAccountPrimaryEndpoint
output vnetId string = virtualNetworkModule.outputs.vnetId
output subnetId string = virtualNetworkModule.outputs.subnetId
output firewallSubnetId string = virtualNetworkModule.outputs.firewallSubnetId
output gatewaySubnetId string = virtualNetworkModule.outputs.gatewaySubnetId
output bastionSubnetId string = virtualNetworkModule.outputs.bastionSubnetId
output firewallId string = azureFirewallModule.outputs.firewallId
output firewallPublicIPId string = azureFirewallModule.outputs.publicIPId
output gatewayId string = virtualNetworkGatewayModule.outputs.gatewayId
output gatewayPublicIPId string = virtualNetworkGatewayModule.outputs.publicIPId
output bastionHostId string = bastionHostModule.outputs.bastionHostId
output bastionPublicIPId string = bastionHostModule.outputs.publicIPId
output logAnalyticsWorkspaceId string = logAnalyticsWorkspaceModule.outputs.workspaceId
output networkWatcherId string = networkWatcherModule.outputs.networkWatcherId
