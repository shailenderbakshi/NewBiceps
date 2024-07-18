param location string = resourceGroup().location
param vnetName string = 'myVnet'
param adminUsername string
param adminPassword string
var vmNames = [
  'vm-prod-managerapp'
  'vm-prod-mirth'
  'vm-prod-winsrv'
]

module virtualNetwork './modules/virtualNetwork.bicep' = {
  name: 'virtualNetwork'
  params: {
    location: location
    vnetName: vnetName
  }
}

// Existing reference to the virtual network
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: virtualNetwork.outputs.vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'default'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

module virtualMachines './modules/virtualMachine.bicep' = [for vmName in vmNames: {
  name: 'virtualMachine-${vmName}'
  params: {
    location: location
    vmName: vmName
    adminUsername: adminUsername
    adminPassword: adminPassword
    subnetId: subnet.id
    vmSize: 'Standard_B2ms'
    osDiskSizeGB: 128
  }
}]
