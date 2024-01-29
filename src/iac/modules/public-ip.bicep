param location string = resourceGroup().location


resource aksPublicIp 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: 'aks_ingress'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: 'cloudbanksimple-aks'
    }
  }
  zones: []
}
