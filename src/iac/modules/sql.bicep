param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: 'cloudBankSqlServer'
  location: location
  properties: {
    administratorLogin: 'sqlAdmin'
    administratorLoginPassword: 'P@ssw0rd'
    version: '12.0'
  }
}

resource sqlServerElasticPool 'Microsoft.Sql/servers/elasticPools@2023-05-01-preview' = {
  parent: sqlServer
  name: 'elasticPool'
  location: location
  sku: {
    name: 'StandardPool'
    capacity: 50
  }
  properties: {
    perDatabaseSettings: {
      minCapacity: 10
      maxCapacity: 20
    }
  }
}

resource sqlServerDatabases 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: 'cloudBank'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    elasticPoolId: sqlServerElasticPool.id
  }
}
