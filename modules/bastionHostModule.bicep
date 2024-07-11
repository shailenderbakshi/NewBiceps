param bastionHostName string
param location string
param bastionSubnetId string
param publicIpName string

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'baspip-tpranly-hub-use-001'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2021-02-01' = {
  name: bastionHostName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'bastionHostIpConfig'
        properties: {
          subnet: {
            id: bastionSubnetId
          }
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
  }
}

output bastionHostId string = bastionHost.id
output publicIPId string = publicIPAddress.id
