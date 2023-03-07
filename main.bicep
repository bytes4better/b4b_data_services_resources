@minLength(3)
@maxLength(20)
param prefixName string = 'b4b-dta-svc'
param environment string = 'dev'
param resourceGroupName string = '${prefixName}-rg-${environment}'
param location string = 'westeurope'
param vnetName string = '${prefixName}-vnet-${environment}'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    product: 'data-service'
  }
  managedBy: 'string'
  properties: {}
}

module vnet 'vnet.bicep' = {
  name: '<linked-deployment-name>'
  scope: resourceGroup(rg.name)
  params: {
    location : location
    vnetName: vnetName
  }
}


        
