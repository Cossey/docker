# Docker Hub Dockerfiles
Dockerfiles and scripts for Images at https://hub.docker.com/r/kosdk

You can build the images using the `build.ps1` powershell script in each folder to build the respective images. Check the sections below for any parameters that you can pass to the builder.

The PowerShell scripts have a `$tag` variable that you can easily edit for your docker hub repository/custom image name.

> These build scripts use the experimental `buildx` command in _Docker Desktop 2.0.4.0 or higher_ to build for multiple Linux platforms. You need to enable experimental features and be using . Read more about [this command here](https://docs.docker.com/buildx/working-with-buildx/).

## choco _[Chocolatey Package Manager]_
Supports building packages and pushing them to a Chocolatey Registry in a Linux Container. _This image only supports the `choco pack`, `choco new` and `choco push` commands._

### Supported Platforms
Choco
* linux/386
* linux/amd64
* linux/arm/v6
* linux/arm/v7
* linux/arm64

Choco with PowerShell
* linux/amd64
* linux/arm/v7
* linux/arm64

### Build Commands
```
.\build <chver> <psver> <btype>
```

#### Parameters
`<chver>` the Chocolatey Version _Required_  
`<psver>` the PowerShell Version _Optional_  
`<btype>` the Build Type. Ether empty or `ignorecore`. _Optional_

If `<psver>` is provided then this will build the PowerShell variant image; if `ignorecore` is provided then this will not build the base chocolatey image.

#### Examples
Build Chocolatey 0.10.14-beta base image and build the Chocolatey PowerShell 6.2.2 image.
```
.\build 0.10.14-beta 6.2.2
```

Build the Chocolatey PowerShell 6.2.2 image.
```
.\build 0.10.14-beta 6.2.2 ignorecore
```
> The PowerShell image needs the Base Chocolatey Image to build.

## powershellcore _[PowerShell Core]_
Run PowerShell Core in a Linux Container.

### Supported Platforms
* linux/amd64
* linux/arm/v7
* linux/arm64

### Build Commands
```
.\build <psver>
```

#### Parameters
`<psver>` the PowerShell version. _Required_

#### Examples
Build PowerShell version 6.2.2 container
```
.\build 6.2.2
```

## dhcpd _[ISC DHCP Server]_
The ISC DHCP Server running in a Docker Container.

### Supported Platforms
_Depends on Version and Base Operating System. Debian has the best platform coverage for the latest version:_

* linux/386
* linux/amd64
* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/ppc64le
* linux/s390x

### Versions
This script has a lookup table, as each Operating System release supports a specific version.

Debian
* 4.3.1
* 4.3.5
* 4.4.1

Ubuntu
* 4.3.3
* 4.3.5
* 4.4.1

### Build Commands
```
.\build <ddver> <os>
```

#### Parameters
`<ddver>` The ISC DHCPD Version. _Required_  
`<os>` The Base OS Image. Either `debian` (default) or `ubuntu`. _Optional_

#### Examples
Build version 4.3.5 on Debian
```
.\build 4.3.5
```

Build version 4.4.1 on Ubuntu
```
.\build 4.4.1 ubuntu
```

## duckdns _[DuckDNS Updater Client]_
A linux container to update your Dynamic DNS with [DuckDNS](www.duckdns.org).

Refer to the [readme](duckdns/README.md) file in the folder for further details.