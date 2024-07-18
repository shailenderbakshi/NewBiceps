@description('Location for all resources.')
param location string = 'East US'

@description('Admin username for the Virtual Machine.')
param adminUsername string

@description('Admin password for the Virtual Machine.')
@secure()
param adminPassword string

@description('The name of the Virtual Network.')
param virtualNetworkName string = 'vnet-tpr-app-use'

@description('The name of the subnet.')
param subnetName string = 'snet-tpr-app-use'

@description('The name of the Network Security Group.')
param nsgName string = 'nsg-prod-managerapp'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: virtualNetworkName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  parent: virtualNetwork
  name: subnetName
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' existing = {
  name: nsgName
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-02-01' = [for name in [
  'vm-prod-managerapp',
  'vm-prod-mirth',
  'vm-prod-winsrv'
]: {
  name: 'nic-${name}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}]

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-03-01' = [for name in [
  'vm-prod-managerapp',
  'vm-prod-mirth',
  'vm-prod-winsrv'
]: {
  name: name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: name
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'Disk-${name}-OS1'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        diskSizeGB: 128
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface[name].id
        }
      ]
    }
  }
}]
