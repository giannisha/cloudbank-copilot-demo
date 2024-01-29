
$publicIp = az network public-ip show --name $env:INGRESS_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query ipAddress -o tsv
$publicIpId = az network public-ip show --name $env:INGRESS_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query id -o tsv
$publicIpRg = az network public-ip show --name $env:INGRESS_NAME --resource-grou $env:CLOUDBANK_RESOURCE_GROUP --query resourceGroup -o tsv
$fqdn = az network public-ip show --name $env:INGRESS_NAME --resource-group $env:CLOUDBANK_RESOURCE_GROUP --query dnsSettings.fqdn -o tsv
$domainLabel = $fqdn.Split('.')[0]

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx `
  --namespace ingress-nginx --create-namespace `
  --values src/app/charts/ingress/Values.yaml `
  --set controller.loadBalancerIP="$publicIp" `
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-ipv4"="$publicIp" `
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-resource-group"="$publicIpRg" `
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"="$domainLabel" `
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-resource"="$publicIpId" `
  --set controller.extraArgs.v="2" `
  --version "4.7.3" `
  --timeout 1m0s