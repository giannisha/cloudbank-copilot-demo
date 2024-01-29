
$webIdentityClientId = az identity show --name $evn:WEB_IDENTITY_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query clientId -o tsv

$tenantId = az account show --query tenantId -o tsv
$fqdn = az network public-ip show --name $env:INGRESS_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query dnsSettings.fqdn -o tsv
$region = az account list-locations --query "[?name == '$($env:LOCATION)'].displayName" -o tsv


helm upgrade --install web src/app/charts/web -f src/app/charts/web/Values.yaml `
  --set azure.tenantId=$tenantId `
  --set identity.clientid=$webIdentityClientId `
  --set workload.domainname="$fqdn" `
  --set azure.region="$region" `
  --wait