// policies/policyModule.bicep
param policyDefinitionName string
param policyDisplayName string
param policyDescription string
param allowedRegions array

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyDefinitionName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: policyDisplayName
    description: policyDescription
    metadata: {
      category: 'General'
    }
    parameters: {
      allowedRegions: {
        type: 'Array'
        metadata: {
          description: 'The list of allowed regions.'
          displayName: 'Allowed Regions'
        }
        allowedValues: allowedRegions
        defaultValue: [
          'East US'
        ]
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'location'
            notIn: '[parameters('allowedRegions')]'
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: '${policyDefinitionName}-assignment'
  properties: {
    displayName: policyDisplayName
    policyDefinitionId: policyDefinition.id
    parameters: {
      allowedRegions: {
        value: [
          'East US'
        ]
      }
    }
  }
}
