param aksClusterName string

// ############################################
// Built-in Roles
// ############################################

resource networkContributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  name: '4d97b98b-1d4f-4787-a291-c67834d212e7'
  scope: subscription()
}

resource acrPullRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  name: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
  scope: subscription()
}

resource sqlServerContributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  name: '6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437'
  scope: subscription()
}

// ############################################
// AKS
// ############################################
resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-07-02-preview' existing = {
  name: aksClusterName
}

resource identityRoleAssignDeployment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: resourceGroup()
  name: guid(resourceGroup().id, acrPullRoleDefinition.id)
  properties: {
    roleDefinitionId: acrPullRoleDefinition.id 
    principalId: aksCluster.properties.identityProfile.kubeletidentity.objectId
    principalType: 'ServicePrincipal'
  }
}

resource networkContributorRoleAssignDeployment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: resourceGroup()
  name: guid(resourceGroup().id, networkContributorRoleDefinition.id)
  properties: {
    roleDefinitionId: networkContributorRoleDefinition.id 
    principalId: aksCluster.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

// ############################################
// API User
// ############################################
resource apiIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: 'api-identity'
}

resource usersApiSqlServerContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: resourceGroup()
  name: guid(resourceGroup().id, apiIdentity.id, sqlServerContributorRoleDefinition.id)
  properties: {
    roleDefinitionId: sqlServerContributorRoleDefinition.id 
    principalId: apiIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}
