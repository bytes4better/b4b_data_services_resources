param location string
param vnetName string

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
