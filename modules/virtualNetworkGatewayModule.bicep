// param gatewayName string
// param location string = resourceGroup().location
// param gatewaySubnetId string
// param publicIpName string

// resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
//   name: 'vgwpip-tpranly-hub-use-001'
//   location: location
//   sku: {
//     name: 'Standard'
//   }
//   properties: {
//     publicIPAllocationMethod: 'Static'
//   }
// }

// resource virtualNetworkGateway 'Microsoft.Network/virtualNetworkGateways@2021-02-01' = {
//   name: gatewayName
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: 'vnetGatewayConfig'
//         properties: {
//           publicIPAddress: {
//             id: publicIP.id
//           }
//           privateIPAddress: null
//           privateIPAllocationMethod: 'Dynamic'
//           subnet: {
//             id: gatewaySubnetId
//           }
//         }
//       }
//     ]
//     gatewayType: 'Vpn'
//     vpnType: 'RouteBased'
//     enableBgp: false
//     sku: {
//       name: 'VpnGw1'
//       tier: 'VpnGw1'
//     }
//     vpnClientConfiguration: {
//       vpnClientAddressPool: {
//         addressPrefixes: [
//           '172.16.0.0/24'
//         ]
//       }
//     }
//   }
// }

// output gatewayId string = virtualNetworkGateway.id
// output publicIPId string = publicIP.id
