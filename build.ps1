param(
   [String]$dockerpush="false",
   [String]$smoketest="false"
)

$ErrorActionPreference = "Stop"

docker build -t shukriadams/windows-node20-build .
Write-Host "container built"

if ($dockerpush -eq "true"){
    Write-Host "starting docker push"
    Set-Variable -Name TAG -Value (git describe --tags --abbrev=0)
    
    if (!$TAG){
        Write-host "TAG not set, exiting"
        exit 0
    }

    Write-Host "Tag $TAG detected"
    
    docker tag shukriadams/windows-node20-build:latest shukriadams/windows-node20-build:$TAG 
    docker login -u $DOCKER_USER -p $DOCKER_PASS 
    docker push shukriadams/windows-node20-build:$TAG 
    Write-Host "container push complete"    
}
