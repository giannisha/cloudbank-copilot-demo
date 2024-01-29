
$apiIdentityClientId = az identity show --name $env:API_IDENTITY_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query clientId -o tsv

$tenantId = az account show --query tenantId -o tsv
$fqdn = az network public-ip show --name $env:INGRESS_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query dnsSettings.fqdn -o tsv
$region = az account list-locations --query "[?name == '$($env:LOCATION)'].displayName" -o tsv


helm upgrade --install api src/app/charts/api -f src/app/charts/api/Values.yaml `
  --set azure.tenantId=$tenantId `
  --set identity.clientid=$apiIdentityClientId `
  --set workload.domainname="$fqdn" `
  --set azure.region="$region" `
  --wait