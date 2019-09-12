$ver = $args[0]
$platform = $args[1]
$tag = "kosdk/dhcpd"

$ubuntu = @("4.3.3", "16.04", "linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/ppc64le,linux/s390x"), 
        @("4.3.5", "18.04", "linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/ppc64le,linux/s390x"), 
        @("4.4.1", "19.04", "linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/ppc64le,linux/s390x")

$debian = @("4.3.1", "jessie-slim", "linux/arm/v6,linux/arm/v7,linux/386,linux/amd64"),
        @("4.3.5", "stretch-slim", "linux/arm/v6,linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/ppc64le,linux/s390x"),
        @("4.4.1", "buster-slim", "linux/arm/v6,linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/ppc64le,linux/s390x")

$versions = $debian
$plat = "debian"

if (!$ver) {$ver = "all"}

switch ($platform) {
    "ubuntu" {
        $versions = $ubuntu
        $plat = "ubuntu"
    }
}

switch ($ver) {
    "all" {  
        foreach($vers in $versions) {
            if ($versions[$versions.Count-1][0] -eq $vers[0]) {
                docker buildx build --no-cache --build-arg PLAT=$plat --build-arg VER=$($vers[1]) --platform $($vers[2]) -t ${tag}:$($vers[0]) -t ${tag}:latest . --push
            } else {
                docker buildx build --no-cache --build-arg PLAT=$plat --build-arg VER=$($vers[1]) --platform $($vers[2]) -t ${tag}:$($vers[0]) . --push
            }
        }
    }
    "latest" {
        $latest = $versions[$versions.Count-1]
        docker buildx build --no-cache --build-arg PLAT=$plat --build-arg VER=$($latest[1]) --platform $($latest[2]) -t ${tag}:$($latest[0]) -t ${tag}:latest . --push
    }
    Default {
        foreach ($vers in $versions) { 
            if ($ver -eq $vers[0]) {
                docker buildx build --no-cache --build-arg PLAT=$plat --build-arg VER=$($vers[1]) --platform $($vers[2]) -t ${tag}:$($vers[0]) . --push 
            }
        }
    }
}