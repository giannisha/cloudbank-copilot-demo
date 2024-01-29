param location string = resourceGroup().location
param aksOidcIssuerURL string

// ############################################
// App Managed Identities
// ############################################

var apps = [
  'api'
  'speech-api'
  'web'
]

resource usersApiIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = [for app in apps: {
  name: '${app}-identity'
  location: location
}]

resource usersApiFederatedCredential 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = [for (app, i) in apps: {
  parent: usersApiIdentity[i]
  name: '${app}-federated-credential'
  properties: {
    audiences: ['api://AzureADTokenExchange']
    issuer: aksOidcIssuerURL
    subject: 'system:serviceaccount:default:${app}-identity'
  }
}]

// ############################################
// Az Script Execution Users
// ############################################
resource scriptIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'scripts-identity'
  location: location
}
