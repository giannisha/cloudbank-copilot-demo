# File: run.ps1

param (
    [string]$Command
)

# Load environment variables from .env file
Get-Content .env | ForEach-Object {
    $name, $value = $_.split('=')
    if ([string]::IsNullOrWhiteSpace($name) || $name.Contains('#')) {
        return
    }
    Set-Content env:\$name $value
}

function Deploy-Infra {
    # Replace this with your actual build command
    Write-Host "Deploying infra..."
    & ./src/ops/deploy-infra.ps1
}

function Remove-Infra {
    # Replace this with your actual run command
    Write-Host "Removing infra resources..."
    & ./src/ops/remove-infra.ps1
}

function Auth-Aks {
    # Replace this with your actual test command
    Write-Host "Authenticating to AKS..."
    # az login
    az aks get-credentials --resource-group $env:CLOUDBANK_RESOURCE_GROUP --name cloudbank-simple-aks --overwrite-existing --admin
}

function Build-Api {
    # Replace this with your actual run command
    Write-Host "Building api container..."
    & ./src/ops/build-api.ps1
}


function Deploy-Api {
    # Replace this with your actual run command
    Write-Host "Deploying api container..."
    & ./src/ops/deploy-api.ps1
}

function Build-Speech-Api {
    # Replace this with your actual run command
    Write-Host "Building speech api container..."
    & ./src/ops/build-speech-api.ps1
}

function Deploy-Speech-Api {
    # Replace this with your actual run command
    Write-Host "Deploying speech api container..."
    & ./src/ops/deploy-speech-api.ps1
}

function Build-Web {
    # Replace this with your actual run command
    Write-Host "Building web container..."
    & ./src/ops/build-web.ps1
}

function Deploy-Web {
    # Replace this with your actual run command
    Write-Host "Deploying web container..."
    & ./src/ops/deploy-web.ps1
}

function Remove-Web {
    # Replace this with your actual run command
    Write-Host "Removing web container..."
    & ./src/ops/remove-web.ps1
}

function Remove-Api {
    # Replace this with your actual run command
    Write-Host "Removing api container..."
    & ./src/ops/remove-api.ps1
}

function Remove-Speech-Api {
    # Replace this with your actual run command
    Write-Host "Removing speech api container..."
    & ./src/ops/remove-speech-api.ps1
}

function Deploy-Ingress {
    # Replace this with your actual run command
    Write-Host "Deploying ingress..."
    & ./src/ops/deploy-ingress.ps1
}

function Remove-Ingress {
    # Replace this with your actual run command
    Write-Host "Removing ingress..."
    & ./src/ops/remove-ingress.ps1
}

function Set-Sub {
    # Replace this with your actual run command
    Write-Host "Setting subscription..."
    & ./src/ops/set-default-sub.ps1
}

function Install-Ingress {
    # Replace this with your actual run command
    Write-Host "Installing ingress..."
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
}


switch ($Command) {
    "deploy-infra" {
        Deploy-Infra
    }
    "remove-infra" {
        Remove-Infra
    }
    "auth-aks" {
        Auth-Aks
    }
    "build-api" {
        Build-Api
    }
    "deploy-api" {
        Deploy-Api
    }
    "remove-speech-api" {
        Remove-Speech-Api
    }
    "build-speech-api" {
        Build-Speech-Api
    }
    "deploy-speech-api" {
        Deploy-Speech-Api
    }
    "remove-api" {
        Remove-Api
    }
    "build-web" {
        Build-Web
    }
    "deploy-web" {
        Deploy-Web
    }
    "remove-web" {
        Remove-Web
    }
    "deploy-ingress" {
        Deploy-Ingress
    }
    "remove-ingress" {
        Remove-Ingress
    }
    "set-sub" {
        Set-Sub
    }
    "install-ingress" {
        Install-Ingress
    }
    default {
        Write-Host "Unknown command: $Command"
        Write-Host "Usage: run.ps1 [deploy-infra|remove-infra|auth-aks|build-api|deploy-api|remove-api|build-web|deploy-web|remove-web|deploy-ingress|remove-ingress|set-sub|install-ingress]"
    }
}
