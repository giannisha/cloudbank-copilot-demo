
$speechApiIdentityClientId = az identity show --name $env:SPEECH_API_IDENTITY_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query clientId -o tsv

$tenantId = az account show --query tenantId -o tsv
$fqdn = az network public-ip show --name $env:INGRESS_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query dnsSettings.fqdn -o tsv
$region = az account list-locations --query "[?name == '$($env:LOCATION)'].displayName" -o tsv


helm upgrade --install speech-api src/app/charts/speech-api -f src/app/charts/speech-api/Values.yaml `
  --set azure.tenantId=$tenantId `
  --set identity.clientid=$speechApiIdentityClientId `
  --set workload.domainname="$fqdn" `
  --set azure.region="$region" `
  --wait