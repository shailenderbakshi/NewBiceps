param vnetName string
param location string = resourceGroup().location
param addressPrefix string = '10.0.0.0/16'
param subnetName string = 'default'
param subnetPrefix string = '10.0.0.0/24'
param firewallSubnetPrefix string = '10.0.1.0/24'
param gatewaySubnetPrefix string = '10.0.2.0/24'
param appGatewaySubnetPrefix string = '10.0.3.0/24'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [addressPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      },
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: firewallSubnetPrefix
        }
      },
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: gatewaySubnetPrefix
        }
      },
      {
        name: 'ApplicationGatewaySubnet'
        properties: {
          addressPrefix: appGatewaySubnetPrefix
        }
      }
    ]
  }
}

output vnetId string = virtualNetwork.id
output subnetId string = virtualNetwork.properties.subnets[0].id
output firewallSubnetId string = virtualNetwork.properties.subnets[1].id
output gatewaySubnetId string = virtualNetwork.properties.subnets[2].id
output appGatewaySubnetId string = virtualNetwork.properties.subnets[3].id
