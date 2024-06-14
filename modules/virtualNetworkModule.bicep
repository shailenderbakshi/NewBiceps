param vnetName string
param location string = resourceGroup().location
param addressPrefix string = '10.0.0.0/16'
param subnetName string = 'default'
param subnetPrefix string = '10.0.0.0/24'

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
      }
    ]
  }
}

output vnetId string = virtualNetwork.id
output subnetId string = virtualNetwork.properties.subnets[0].id
