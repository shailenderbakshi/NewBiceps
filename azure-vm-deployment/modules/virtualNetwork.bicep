param location string
param vnetName string
param subnetName string = 'default'
param addressPrefix string = '10.0.0.0/16'
param subnetPrefix string = '10.0.0.0/24'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
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

output virtualNetworkResource object = virtualNetwork
output subnetId string = virtualNetwork.properties.subnets[0].id
