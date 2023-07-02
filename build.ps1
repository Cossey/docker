param (
    [Parameter(Mandatory=$true)][string]$image,
    [string]$version,
    [string]$output = "push",
    [string]$outputpath
)

Write-Host "Unified Build Tool"
Write-Host "Copyright © 2023 Stewart Cossey"
Write-Host "==============================="

if ([string]::IsNullOrWhiteSpace(${env:DOCKER_HUB_PROFILE})) {
    Write-Host "Environment variable DOCKER_HUB_PROFILE must be set."
    exit
}

$tag = "${env:DOCKER_HUB_PROFILE}/$image"

Switch ($output.ToLower()) {
    "push" {}
    "load" {break}
    "folder" {
        if (!$outputpath) {
            Write-Host "Required parameter -outputpath is missing" -ForegroundColor Red
            exit 2
        }
    }
    default {
        Write-Host "Invalid output type" -ForegroundColor Red
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
        if ($VERSIONFILE -and $VERSIONREGEX) {
            $vf = Join-Path -Path $image -ChildPath $VERSIONFILE
            $script:tagver = (Get-Content $vf | Select-String -Pattern $VERSIONREGEX).Matches[0].Groups[1].Value
        } else {
            Write-Host "The version parameter is required for this image" -ForegroundColor Red
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
            $parts = $_.Split('=', 2)
            $name = $parts[0]
            $value = $parts[1]
            Set-Variable -Name $name -Value $value -Scope script
        }
    }
}

function DownloadFiles() {
    if ($DOWNLOADFILE) {
        Invoke-WebRequest -Uri $DOWNLOADFILE -OutFile (Join-Path $image $(Split-Path -Path $DOWNLOADFILE -Leaf))
    }
}

if (Test-Path "./$image") {
    if (Test-Path "./$image/build.env") {
        LoadEnvVarFile "./$image/build.env"
        DownloadFiles
        ParseVersion
        BuildX
    } else {
        Write-Host "The image does not support the unified build tool" -ForegroundColor Red
        exit 4
    }
} else {
    Write-Host "Folder not found: $image" -ForegroundColor Red
}