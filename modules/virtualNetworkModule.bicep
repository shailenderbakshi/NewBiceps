param vnetName string
param location string
param addressPrefix string = '10.70.0.0/16'
param firewallSubnetPrefix string = '10.70.0.128/26'
param gatewaySubnetPrefix string = '10.70.0.0/26'
param appGatewaySubnetPrefix string = '10.70.0.64/26'
param bastionSubnetPrefix string = '10.70.0.192/26'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [addressPrefix]
    }
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: firewallSubnetPrefix
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: gatewaySubnetPrefix
        }
      }
      {
        name: 'AppGatewaySubnet'
        properties: {
          addressPrefix: appGatewaySubnetPrefix
        }
      }
      {
        name: 'AzureBastionSubnet' // Corrected the subnet name for Azure Bastion
        properties: {
          addressPrefix: bastionSubnetPrefix
        }
      }
    ]
  }
}

output vnetId string = virtualNetwork.id
output firewallSubnetId string = virtualNetwork.properties.subnets[0].id
output gatewaySubnetId string = virtualNetwork.properties.subnets[1].id
output appGatewaySubnetId string = virtualNetwork.properties.subnets[2].id
output bastionSubnetId string = virtualNetwork.properties.subnets[3].id
