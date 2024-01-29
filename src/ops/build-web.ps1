
$services = @(
  @{ name = "web"; image="$env:ACR_NAME.azurecr.io/web:latest"; folder="src/app/web" }
)

$services |ForEach-Object {
  $svcName = $_.Name
  $svcImage = $_.Image
  $svcFolder = $_.Folder
  $svcDockerfile = $_.Folder + "/Dockerfile"
  Write-Host "Building $svcName as $svcImage from $svcDockerfile"
  az acr build --registry $env:ACR_NAME --image $svcImage --file $svcDockerfile $svcFolder
}