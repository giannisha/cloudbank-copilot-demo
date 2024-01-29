param location string
param resourceGroupName string
param adminPrincipalId string

// ###############################
// # SQL Server
// ###############################
resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' existing = {
  name: 'cloudBankSqlServer'
}

resource scriptsIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: 'scripts-identity'
}

resource deployIdentityToSqlScript 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'deployIdentityToSqlScript'
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${scriptsIdentity.id}': {}
    }
  }
  properties: {
    azCliVersion: '2.53.0'
    scriptContent: 'az sql server ad-admin create --resource-group ${resourceGroupName} --server-name ${sqlServer.name} --display-name ${sqlServer.name} --object-id ${adminPrincipalId}'
    retentionInterval: 'P1D'
    cleanupPreference: 'OnExpiration'
    timeout: 'PT1H'
  }
}
