$ver = $args[0]
$psver = $args[1]
$buildtype = $args[2]
$tag = "${env:DOCKER_HUB_PROFILE}/choco"

if ($buildtype -ne "ignorecore") {
    docker buildx build --build-arg CVER=${ver} --platform linux/amd64,linux/arm/v7,linux/arm64,linux/386 -t ${tag}:${ver} -t ${tag}:latest . --push
}
if ($psver) {
    docker buildx build -f Dockerfile.ps --build-arg CVER=${ver} --build-arg PSVER=${psver} --platform linux/amd64,linux/arm/v7,linux/arm64 -t ${tag}:${ver}-ps$psver -t ${tag}:ps . --push
}