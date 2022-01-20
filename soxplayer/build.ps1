$ver = (Get-Content ./program.js | Select-String -Pattern 'Version: ([0-9]+\.[0-9]+)').Matches[0].Groups[1].Value
$tag = "${env:DOCKER_HUB_PROFILE}/soxplayer"

docker buildx build --build-arg VER=$ver --platform linux/arm/v6,linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/s390x -t ${tag}:$ver -t ${tag}:latest . --push 