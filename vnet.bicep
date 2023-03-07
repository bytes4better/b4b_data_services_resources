param location string
param vnetName string
param prefixName string

@description('Address prefix')
param vnetAddressPrefix string = '10.0.0.0/16'
@description('Subnet 1 Prefix')
param appSubnetPrefix string = '10.0.0.0/24'
@description('Subnet 1 Name')
param appSubnetName string = 'AppSubnet'
@description('Subnet 2 Prefix')
param dbSubnetPrefix string = '10.0.1.0/24'
@description('Subnet 2 Name')
param dbSubnetName string = 'DbSubnet'

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  tags: {
    product: 'data-service'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
      }
    subnets: [
      {
        name: appSubnetName
        properties: {
          addressPrefix: appSubnetPrefix
        }
      }
      {
        name: dbSubnetName
        properties: {
          addressPrefix: dbSubnetPrefix
        }
      }
    ]
  }
}

// create a serverless mssql server plus database
@description('The administrator username of the SQL logical server.')
param administratorLogin string

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string

@description('The name of the SQL logical server.')
param serverName string = '${prefixName}-sqlserver}'

@description('The name of the SQL Database.')
param sqlDBName string = 'SampleDB'

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2021-05-01-preview' = {
  name: sqlDBName
  location: location
  parent: sqlServer
  sku: {
    capacity: 1
    family: 'Gen5'
    name: 'GP_S_Gen5_1'
  }
  properties: {
    minCapacity: any('0.5')
  }
}


