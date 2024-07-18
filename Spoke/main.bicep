// Parameters for vm-prod-manager
param vmName1 string = 'vm-prod-manager'
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
param nsgName string = 'nsg-prod-manager'
param osType string = 'Windows'
param osVersion string = '2022-Datacenter'

// Parameters for vm-prod-mirth
param vmName2 string = 'vm-prod-mirth'
param nicName2 string = 'nic-prod-mirth'

// Existing virtual network and subnet
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.80.2.0/24'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: subnetName
  parent: vnet
  properties: {
    addressPrefix: '10.80.2.0/26'
  }
}

// Network security group
resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgName
  location: location
}

// Network interface for vm-prod-manager
resource nic1 'Microsoft.Network/networkInterfaces@2021-05-01' = {
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

// Network interface for vm-prod-mirth
resource nic2 'Microsoft.Network/networkInterfaces@2021-05-01' = {
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

// Virtual machine vm-prod-manager
resource vm1 'Microsoft.Compute/virtualMachines@2021-07-01' = {
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
  dependsOn: [
    nic1
  ]
}

// Virtual machine vm-prod-mirth
resource vm2 'Microsoft.Compute/virtualMachines@2021-07-01' = {
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
  dependsOn: [
    nic2
  ]
}
