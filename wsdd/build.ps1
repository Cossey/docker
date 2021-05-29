$versionLine = (Get-Content .\wsdd.py | Where-Object {$_ -match 'WSDD_VERSION ='})
$version = (([regex]".*'(.*)'").Matches($versionLine))[0].Groups[1].Value

$tag = "${env:DOCKER_HUB_PROFILE}/wsdd"

docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64 -t ${tag}:${version} -t ${tag}:latest . --push