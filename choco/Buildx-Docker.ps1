$ver = $args[0]
$psver = $args[1]
$buildtype = $args[2]

if ($buildtype -ne "ignorecore") {
    docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64,linux/arm/v6,linux/386 -t kosdk/choco:${ver} -t kosdk/choco:latest . --push
}
if ($psver) {
    docker buildx build -f Dockerfile.ps --build-arg CVER=${ver} --build-arg PSVER=${psver} --platform linux/amd64,linux/arm/v7,linux/arm64 -t kosdk/choco:${ver}-ps$psver -t kosdk/choco:ps . --push
}