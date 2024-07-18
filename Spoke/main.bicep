param vmName1 string = 'vm-prod-manager'
param vmName2 string = 'vm-prod-mirth'
param vmName3 string = 'vm-prod-winsrv'
param adminUsername string
param adminPassword string

param subscriptionName string = 'pCare TPR production'
param resourceGroupName string = 'rg-tpr-app-use-001'
param location string = 'East US'
param vmSize string = 'Standard_B2ms'
param osDiskType string = 'Premium_LRS'
param osDiskSizeGB int = 128

param vnetName string = 'vnet-tpr-app-use'
param subnetName string = 'snet-tpr-app-use'
param nicName1 string = 'nic-prod-manager'
param nicName2 string = 'nic-prod-mirth'
param nicName3 string = 'nic-prod-winsrv'
param nsgName string = 'nsg-prod-manager'
param osType string = 'Windows'
param osVersion string = '2022-Datacenter'

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnetName
  resourceGroupName: resourceGroupName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' existing = {
  name: subnetName
  parent: vnet
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' existing = {
  name: nsgName
  resourceGroupName: resourceGroupName
}

resource nic1 'Microsoft.Network/networkInterfaces@2021-05-01' = if (!exists('Microsoft.Network/networkInterfaces', nicName1)) {
  name: nicName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource nic2 'Microsoft.Network/networkInterfaces@2021-05-01' = if (!exists('Microsoft.Network/networkInterfaces', nicName2)) {
  name: nicName2
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource nic3 'Microsoft.Network/networkInterfaces@2021-05-01' = if (!exists('Microsoft.Network/networkInterfaces', nicName3)) {
  name: nicName3
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource vm1 'Microsoft.Compute/virtualMachines@2021-07-01' = if (!exists('Microsoft.Compute/virtualMachines', vmName1)) {
  name: vmName1
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName1
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        name: 'Disk-prod-manager-OS1'
        diskSizeGB: osDiskSizeGB
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: osVersion
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic1.id
        }
      ]
    }
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2021-07-01' = if (!exists('Microsoft.Compute/virtualMachines', vmName2)) {
  name: vmName2
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName2
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        name: 'Disk-prod-mirth-OS1'
        diskSizeGB: osDiskSizeGB
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: osVersion
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic2.id
        }
      ]
    }
  }
}

resource vm3 'Microsoft.Compute/virtualMachines@2021-07-01' = if (!exists('Microsoft.Compute/virtualMachines', vmName3)) {
  name: vmName3
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName3
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        name: 'Disk-prod-winsrv-OS1'
        diskSizeGB: osDiskSizeGB
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: osVersion
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic3.id
        }
      ]
    }
  }
}
