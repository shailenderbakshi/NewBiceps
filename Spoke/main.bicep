param vmName string = 'vm-prod-manager'
param adminUsername string
param adminPassword string

param subscriptionName string = 'Shail-Subs'
param resourceGroupName string = 'rg-tpr-app-use-001'
param location string = 'East US'
param vmSize string = 'Standard_B2ms'
param osDiskType string = 'Premium_LRS'
param osDiskSizeGB int = 128

param vnetName string = 'vnet-tpr-app-use'
param subnetName string = 'snet-tpr-app-use'
param nicName string = 'nic-prod-manager'
param nsgName string = 'nsg-prod-manager'
param osType string = 'Windows'
param osVersion string = '2022-Datacenter'

// resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
//   name: resourceGroupName
//   location: location
// }

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: subnetName
  parent: vnet
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgName
  location: location
}

resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName
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

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
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
          id: nic.id
        }
      ]
    }
  }
  dependsOn: [
    nic
  ]
}
