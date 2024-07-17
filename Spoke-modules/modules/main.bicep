param vmName string = 'vm-prod-managerapp'
param adminUsername string
param adminPassword string
param location string = 'East US'

module vnetModule 'vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: 'vnet-tpr-app-use'
    location: location
  }
}

module nsgModule 'nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    nsgName: 'nsg-prod-managerapp'
    location: location
  }
}

module nicModule 'nic.bicep' = {
  name: 'nicDeployment'
  params: {
    nicName: 'nic-prod-managerapp'
    location: location
    subnetId: vnetModule.outputs.subnetId
    nsgId: nsgModule.outputs.nsgId
  }
}

module vmModule 'vm.bicep' = {
  name: 'vmDeployment'
  params: {
    vmName: vmName
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
    nicId: nicModule.outputs.nicId
  }
}
