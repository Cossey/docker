$ver = $args[0]
$tag = "${env:DOCKER_HUB_PROFILE}/duckdns"

docker buildx build --no-cache --build-arg VER=$ver --platform linux/arm/v6,linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/s390x -t ${tag}:$ver -t ${tag}:latest . --push 