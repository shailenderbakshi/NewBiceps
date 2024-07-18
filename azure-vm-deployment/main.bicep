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

var subnetId = virtualNetwork.outputs.subnetId

@batch(
  scope: resourceGroup(),
  dependsOn: [
    virtualNetwork
  ]
)
module virtualMachines 'modules/virtualMachine.bicep' = [for vmName in vmNames: {
  name: 'virtualMachine-${vmName}'
  params: {
    location: location
    vmName: vmName
    adminUsername: adminUsername
    adminPassword: adminPassword
    subnetId: subnetId
    vmSize: 'Standard_B2ms'
    osDiskSizeGB: 128
  }
}]
