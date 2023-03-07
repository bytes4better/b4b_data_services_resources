param prefixName string = 'b4b-dta-svc'
param environment string = 'dev'
param resourceGroupName string = '${prefixName}-rg-${environment}'
param location string = 'westeurope'
param vnetName string = '${prefixName}-vnet-${environment}'


@description('The administrator username of the SQL logical server.')
param administratorLogin string
@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string



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
  name: 'vnetDeploy'
  scope: resourceGroup(rg.name)
  params: {
    prefixName: prefixName
    location : location
    vnetName: vnetName
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}


        
