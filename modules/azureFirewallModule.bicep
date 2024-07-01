param firewallName string
param location string = resourceGroup().location
param vnetId string
param firewallSubnetId string

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'fw-pip-tprany-use-001'
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
            id: firewallSubnetId
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
