param vnetName string
param location string

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'snet-tpr-app-use'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

output subnetId string = vnet.properties.subnets[0].id
