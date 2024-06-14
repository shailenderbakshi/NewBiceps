param appGatewayName string
param location string = resourceGroup().location
param vnetId string
param subnetId string
param publicIpName string

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource appGateway 'Microsoft.Network/applicationGateways@2021-02-01' = {
  name: appGatewayName
  location: location
  properties: {
    sku: {
      name: 'Standard_Small'
      tier: 'Standard'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetId
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIp'
        properties: {
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'httpPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: appGateway.frontendIPConfigurations[0].id
          }
          frontendPort: {
            id: appGateway.frontendPorts[0].id
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'appGatewayRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: appGateway.httpListeners[0].id
          }
          backendAddressPool: {
            id: appGateway.backendAddressPools[0].id
          }
          backendHttpSettings: {
            id: appGateway.backendHttpSettingsCollection[0].id
          }
        }
      }
    ]
  }
}

output appGatewayId string = appGateway.id
output publicIPId string = publicIP.id
