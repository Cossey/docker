$psver = $args[0]
$tag = "${env:DOCKER_HUB_PROFILE}/powershellcore"

docker buildx build --build-arg PSVER=${psver} --platform linux/amd64,linux/arm/v7,linux/arm64 -t ${tag}:${psver} -t ${tag}:latest . --push