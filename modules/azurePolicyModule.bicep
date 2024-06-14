param policyAssignmentName string
param location string = resourceGroup().location

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'auditVMSKU'
  properties: {
    displayName: 'Audit VM SKU'
    mode: 'All'
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Compute/virtualMachines'
      }
      then: {
        effect: 'audit'
      }
    }
    parameters: {}
    policyType: 'Custom'
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: policyAssignmentName
  location: location
  properties: {
    displayName: 'Audit VM SKU Assignment'
    policyDefinitionId: policyDefinition.id
    scope: subscription().id
    enforcementMode: 'DoNotEnforce'
  }
}

output policyDefinitionId string = policyDefinition.id
output policyAssignmentId string = policyAssignment.id
