param (
    [Parameter(Mandatory=$true)][string]$image,
    [string]$version,
    [string]$output = "push",
    [string]$outputpath
)

Write-Host "Unified Build Tool"
Write-Host "Copyright © 2022 Stewart Cossey"
Write-Host "==============================="

$tag = "${env:DOCKER_HUB_PROFILE}/$image"

Switch ($output.ToLower()) {
    "push" {}
    "load" {break}
    "folder" {
        if (!$outputpath) {
            Write-Error "Required parameter outputpath is missing"
            exit 2
        }
    }
    default {
        Write-Error "Invalid output type"
        exit 1
    }
}

function BuildX () {
    $df = Join-Path -Path $image -ChildPath $DOCKERFILE
    Write-Host "Building ${tag}:$tagver using output type $output"
    Switch ($output) {
        "load" {
            docker buildx build -t ${tag}:$tagver -t ${tag}:latest -f $df . --load
        }
        "push" {
            docker buildx build --platform $PLATFORM -t ${tag}:$tagver -t ${tag}:latest -f $df . --push
        }
        "folder" {
            docker buildx build --platform $PLATFORM -t ${tag}:$tagver -t ${tag}:latest -f $df . --output type=local,dest=$outputpath
        }
    }
}

function ParseVersion() {
    if ($version) {
        $script:tagver = $version
    } else {
        if ($VERSIONFILE && $VERSIONREGEX) {
            $vf = Join-Path -Path $image -ChildPath $VERSIONFILE
            $script:tagver = (Get-Content $vf | Select-String -Pattern $VERSIONREGEX).Matches[0].Groups[1].Value
        } else {
            Write-Error "The version parameter is required for this image"
            exit 3
        }
    }
}

function LoadEnvVarFile($path) {
    Get-Content $path | % {
        if ($_ -match '^\s*#') {
            # skip comments
        } elseif ($_ -match '^\s*$') {
            # skip empty lines
        } else {
            $parts = $_.Split('=')
            $name = $parts[0]
            $value = $parts[1]
            Set-Variable -Name $name -Value $value -Scope global
        }
    }
}

if (Test-Path "./$image") {
    if (Test-Path "./$image/build.env") {
        LoadEnvVarFile "./$image/build.env"
        ParseVersion
        BuildX
    } else {
        Write-Error "The image does not support the unified build tool"
        exit 4
    }
} else {
    Write-Error "Folder not found: $image"
}