param location string = resourceGroup().location
param vnetName string = 'myVnet'
param vmName string = 'myVM'
param adminUsername string
param adminPassword string

module virtualNetwork './modules/virtualNetwork.bicep' = {
  name: 'virtualNetwork'
  params: {
    location: location
    vnetName: vnetName
  }
}

module virtualMachine './modules/virtualMachine.bicep' = {
  name: 'virtualMachine'
  params: {
    location: location
    vmName: vmName
    adminUsername: adminUsername
    adminPassword: adminPassword
    subnetId: virtualNetwork.outputs.subnetId
  }
}
