@description('The name of the VNet')
param vnetName string

@description('The name of the subnet within the VNet')
param subnetName string

@description('The address prefix for the VNet')
param vnetAddressPrefix string

@description('The address prefix for the subnet')
param subnetAddressPrefix string

@description('The location where the VNet will be created')
param location string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnetAddressPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

output subnetId string = virtualNetwork.properties.subnets[0].id
