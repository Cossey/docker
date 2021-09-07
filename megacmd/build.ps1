$ver = $args[0]
$tag = "${env:DOCKER_HUB_PROFILE}/megacmd"

docker buildx build -t ${tag}:${ver} -t ${tag}:latest --platform linux/arm/v7,linux/amd64,linux/386 . --push