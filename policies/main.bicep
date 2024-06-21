// main.bicep
module policyModule 'policies/policyModule.bicep' = {
  name: 'deployAuditRegionsPolicy'
  params: {
    policyDefinitionName: 'auditRegionsPolicy'
    policyDisplayName: 'Audit resources in allowed regions'
    policyDescription: 'This policy audits resources that are deployed in non-allowed regions.'
    allowedRegions: [
      'East US'
      'West US'
      'Central US'
    ]
  }
}
