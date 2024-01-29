targetScope = 'subscription'

param location string
param resourceGroupName string

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
}

module aks 'modules/aks.bicep' = {
  name: 'aks'
  scope: rg
  params: {
    location: location
  }
  dependsOn: []
}

module publicIp 'modules/public-ip.bicep' = {
  name: 'publicIp'
  scope: rg
  params: {
    location: location
  }
  dependsOn: []
}

module acr 'modules/acr.bicep' = {
  name: 'acr'
  scope: rg
  params: {
    location: location
  }
  dependsOn: []
}

module sql 'modules/sql.bicep' = {
  name: 'sql'
  scope: rg
  params: {
    location: location
  }
  dependsOn: []
}

module managedIdentities 'modules/managed-identities.bicep' = {
  name: 'managedIdentities'
  scope: rg
  params: {
    location: location
    aksOidcIssuerURL: aks.outputs.aksOidcIssuerURL
  }
  dependsOn: [
    aks
    acr
    sql
  ]
}

module roleAssignments 'modules/role-assignments.bicep' = {
  name: 'roleAssignments'
  scope: rg
  params: {
    aksClusterName: aks.outputs.aksClusterName
  }
  dependsOn: [
    aks
    acr
    managedIdentities
  ]
}
