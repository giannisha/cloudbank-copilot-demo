# az login
az deployment sub create --location $env:LOCATION --resourceGroupName $env:CLOUDBANK_RESOURCE_GROUP --template-file src/iac/main.bicep  --name cloudbank-simple-iac