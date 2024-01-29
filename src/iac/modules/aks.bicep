param location string = resourceGroup().location

var k8sVersion = '1.27.7'
var aksClusterName = 'cloudbank-simple-aks'

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-07-02-preview' = {
  name: aksClusterName
  location: location
  sku: {
    name: 'Base'
    tier: 'Standard'
  }

  identity: {
    type: 'SystemAssigned'
  }

  properties: {
    nodeResourceGroup: 'cloudbank-simple-aks-nodes-rg'
    dnsPrefix: 'cloudbank-simple-aks-dns'
    kubernetesVersion: k8sVersion
    
    autoUpgradeProfile: {
      upgradeChannel: 'stable'
    }
    
    oidcIssuerProfile: {
      enabled: true
    }
    securityProfile: {
      workloadIdentity: {
        enabled: true
      }
    }

    enableRBAC: true
    
    agentPoolProfiles: [
      {
        name: 'systempool'
        vmSize: 'Standard_D2_v2'
        enableAutoScaling: true
        minCount: 1
        maxCount: 1
        count: 1
        osDiskSizeGB: 30
        orchestratorVersion: k8sVersion

        availabilityZones: []

        mode: 'System'
        
        upgradeSettings: {
          maxSurge: '33%'
        }
      }
      {
        name: 'workloadpool'
        vmSize: 'Standard_D2_v2'
        enableAutoScaling: true
        minCount: 1
        maxCount: 1
        count: 1
        osDiskSizeGB: 30
        orchestratorVersion: k8sVersion

        mode: 'User'
        availabilityZones: []

        upgradeSettings: {
          maxSurge: '33%'
        }

        nodeLabels: {
          role: 'workload'
        }
        nodeTaints: ['workload=true:NoSchedule']
        enableNodePublicIP: false
        tags: {}
      }
    ]

    networkProfile: {
      networkPlugin: 'azure'
      networkMode: 'transparent'
      networkPolicy: 'calico'
    }

    addonProfiles: {
      azurePolicy: {
        enabled: false
        config: {}
      }
      azureKeyVaultSecretsProvider: {
        enabled: true
        config: {
          enableSecretRotation: 'true'
          rotationRollInterval: '5m'
        }
      }
    }
  }
}

output aksClusterName string = aksCluster.name 
output aksOidcIssuerURL string = aksCluster.properties.oidcIssuerProfile.issuerURL
