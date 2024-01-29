
$services = @(
  @{ name = "api"; image="$env:ACR_NAME.azurecr.io/api:latest"; folder="src/app/api" }
)

$services |ForEach-Object {
  $svcName = $_.Name
  $svcImage = $_.Image
  $svcFolder = $_.Folder
  $svcDockerfile = $_.Folder + "/Dockerfile"
  Write-Host "Building $svcName as $svcImage from $svcDockerfile"
  az acr build --registry $env:ACR_NAME --image $svcImage --file $svcDockerfile $svcFolder
}