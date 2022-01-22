$image = $args[0]
$type = $args[1]
$tag = "${env:DOCKER_HUB_PROFILE}/$image"

$allalpineplatforms = "linux/arm/v6,linux/arm/v7,linux/arm64,linux/386,linux/amd64,linux/s390x,linux/ppc64le"

function fetchVersion ($file) {
    (Get-Content $file | Select-String -Pattern 'Version: ([0-9]+\.[0-9]+)').Matches[0].Groups[1].Value
}

function buildx ($tagver, $df, $p) {
    Switch ($type) {
        "load" {
            docker buildx build -t ${tag}:$tagver -t ${tag}:latest -f $df . --load
        }
        "push" {
            docker buildx build --platform $p -t ${tag}:$tagver -t ${tag}:latest -f $df . --push
        }
    }

}

Switch ($image)
{
    "duckdns" {
        buildx "$(fetchVersion "duckdns/duckdns.sh")" "duckdns/Dockerfile" $allalpineplatforms
        break
    }
    default {
        Write-Host "Unknown image: $image"
    }
}