# az login
az deployment sub create --location $env:LOCATION --template-file src/iac/main.bicep  --name cloudbank-simple-iac  --parameters resourceGroupName=$env:CLOUDBANK_RESOURCE_GROUP location=$env:LOCATION
