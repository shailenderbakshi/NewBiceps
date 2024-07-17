param vmPrefix string = 'vm-prod-'
param vmNameSuffixes array
param adminUsername string
param adminPassword string
param location string = 'East US'
param nsgPrefix string = 'nsg-prod-'
param nicPrefix string = 'nic-prod-'

module vnetModule '../modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: 'vnet-tpr-app-use'
    location: location
  }
}

module nsgModule '../modules/nsg.bicep' = [for vmNameSuffix in vmNameSuffixes: {
  name: 'nsgDeployment-${vmNameSuffix}'
  params: {
    nsgPrefix: nsgPrefix
    nsgSuffix: vmNameSuffix
    location: location
  }
}]

module nicModule '../modules/nic.bicep' = [for (vmNameSuffix, i) in vmNameSuffixes: {
  name: 'nicDeployment-${vmNameSuffix}'
  params: {
    nicPrefix: nicPrefix
    nicSuffix: vmNameSuffix
    location: location
    subnetId: vnetModule.outputs.subnetId
    nsgId: nsgModule[i].outputs.nsgId
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
