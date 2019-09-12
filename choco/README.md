# Chocolatey Package Manager
Supports building packages and pushing them to a Chocolatey Registry in a Linux Container. _This image only supports the `choco pack`, `choco new` and `choco push` commands._

## Supported Platforms
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

## Build Commands
```
.\build <chver> <psver> <btype>
```

### Parameters
`<chver>` the Chocolatey Version _Required_  
`<psver>` the PowerShell Version _Optional_  
`<btype>` the Build Type. Ether empty or `ignorecore`. _Optional_

If `<psver>` is provided then this will build the PowerShell variant image; if `ignorecore` is provided then this will not build the base chocolatey image.

### Examples
Build Chocolatey 0.10.14-beta base image and build the Chocolatey PowerShell 6.2.2 image.
```
.\build 0.10.14-beta 6.2.2
```

Build the Chocolatey PowerShell 6.2.2 image.
```
.\build 0.10.14-beta 6.2.2 ignorecore
```
> The PowerShell image needs the Base Chocolatey Image to build.