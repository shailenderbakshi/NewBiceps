param firewallName string
param location string = resourceGroup().location
param vnetId string
param subnetName string = 'AzureFirewallSubnet'

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${firewallName}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
  }
}

resource azureFirewall 'Microsoft.Network/azureFirewalls@2021-02-01' = {
  name: firewallName
  location: location
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    networkRuleCollections: []
    applicationRuleCollections: []
    natRuleCollections: []
    ipConfigurations: [
      {
        name: 'azureFirewallIpConfig'
        properties: {
          subnet: {
            id: '${vnetId}/subnets/${subnetName}'
          }
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
  }
}

output firewallId string = azureFirewall.id
output publicIPId string = publicIP.id
