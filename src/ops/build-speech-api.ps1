
$services = @(
  @{ name = "speech-api"; image="$env:ACR_NAME.azurecr.io/speech-api:latest"; folder="src/app/speech-api" }
)

$services |ForEach-Object {
  $svcName = $_.Name
  $svcImage = $_.Image
  $svcFolder = $_.Folder
  $svcDockerfile = $_.Folder + "/Dockerfile"
  Write-Host "Building $svcName as $svcImage from $svcDockerfile"
  az acr build --registry $env:ACR_NAME --image $svcImage --file $svcDockerfile $svcFolder
}