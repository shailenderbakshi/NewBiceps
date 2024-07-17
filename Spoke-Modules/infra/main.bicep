param vmPrefix string = 'vm-prod-'
param vmNameSuffixes array
param adminUsername string
param adminPassword string
param location string = 'East US'

module vnetModule '../modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: 'vnet-tpr-app-use'
    location: location
  }
}

module nsgModule '../modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    nsgName: 'nsg-prod-managerapp'
    location: location
  }
}

module nicModule '../modules/nic.bicep' = [for vmNameSuffix in vmNameSuffixes: {
  name: 'nicDeployment-${vmNameSuffix}'
  params: {
    nicName: '${vmPrefix}${vmNameSuffix}'
    location: location
    subnetId: vnetModule.outputs.subnetId
    nsgId: nsgModule.outputs.nsgId
  }
}]

module vmModule '../modules/vm.bicep' = [for (vmNameSuffix, i) in vmNameSuffixes: {
  name: 'vmDeployment-${vmNameSuffix}'
  params: {
    vmPrefix: vmPrefix
    vmNameSuffix: vmNameSuffix
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
    nicId: nicModule[i].outputs.nicId
  }
}]
