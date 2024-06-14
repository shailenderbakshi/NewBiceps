param appGatewayName string
param location string
param vnetId string
param appGatewaySubnetPrefix string
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

resource applicationGateway 'Microsoft.Network/applicationGateways@2021-02-01' = {
  name: appGatewayName
  location: location
  dependsOn: [
    publicIP
  ]
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
            id: appGatewaySubnetId
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
            id: applicationGateway.frontendIPConfigurations[0].id
          }
          frontendPort: {
            id: applicationGateway.frontendPorts[0].id
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: applicationGateway.httpListeners[0].id
          }
          backendAddressPool: {
            id: applicationGateway.backendAddressPools[0].id
          }
          backendHttpSettings: {
            id: applicationGateway.backendHttpSettingsCollection[0].id
          }
        }
      }
    ]
  }
}

output appGatewayId string = applicationGateway.id
output publicIPId string = publicIP.id
output appGatewaySubnetId string = applicationGateway.properties.gatewayIPConfigurations[0].properties.subnet.id
