param firewallName string
param location string = resourceGroup().location
param vnetId string
param subnetName string = 'AzureFirewallSubnet'

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
            id: null
          }
        }
      }
    ]
  }
}

output firewallId string = azureFirewall.id
