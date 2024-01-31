# az login
az deployment sub create --location $env:LOCATION --template-file src/iac/main.bicep  --name cloudbank-simple-iac --parameters '{ \"resourceGroupName\": \"cloudbank-simple-rg\" }'
