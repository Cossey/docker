$psver = $args[0]

docker buildx build --build-arg PSVER=${psver} --platform linux/amd64,linux/arm/v7,linux/arm64 -t kosdk/powershellcore:${psver} -t kosdk/powershellcore:latest . --push