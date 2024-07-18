param location string
param vnetName string
param addressPrefix string = '10.0.0.0/16'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
  }
}

output vnetName string = virtualNetwork.name
