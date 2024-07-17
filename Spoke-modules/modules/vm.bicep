param vmPrefix string
param vmNameSuffix string
param adminUsername string
param adminPassword string
param location string
param nicId string

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: '${vmPrefix}${vmNameSuffix}'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: '${vmPrefix}${vmNameSuffix}'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicId
        }
      ]
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        diskSizeGB: 128
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
    }
  }
}
