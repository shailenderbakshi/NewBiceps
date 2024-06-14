param appGatewayName string
param location string
param vnetId string
param appGatewaySubnetId string

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${appGatewayName}-pip'
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
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 2
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
            id: publicIPAddress.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGatewayFrontendPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: applicationGateway.properties.frontendIPConfigurations[0].id
          }
          frontendPort: {
            id: applicationGateway.properties.frontendPorts[0].id
          }
          protocol: 'Http'
          sslCertificate: null
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: applicationGateway.properties.httpListeners[0].id
          }
          backendAddressPool: {
            id: applicationGateway.properties.backendAddressPools[0].id
          }
          backendHttpSettings: {
            id: applicationGateway.properties.backendHttpSettingsCollection[0].id
          }
        }
      }
    ]
  }
}

output appGatewayId string = applicationGateway.id
output publicIPId string = publicIPAddress.id
