@description('The name of the API Management instance.')
param apimName string

@description('The location of the API Management instance.')
param location string

@description('The SKU for the API Management instance.')
param skuName string = 'Developer' // Default SKU is Developer. You can change this to Standard, Basic, Premium, etc.

@description('The Publisher email for the API Management service.')
param publisherEmail string

@description('The Publisher name for the API Management service.')
param publisherName string

resource apiManagement 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: apimName
  location: location
  sku: {
    name: skuName
    capacity: 1
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

output apimId string = apiManagement.id
output apimPrimaryEndpoint string = apiManagement.properties.gatewayUrl
