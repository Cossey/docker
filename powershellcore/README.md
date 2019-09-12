# PowerShell Core
Run PowerShell Core in a Linux Container.

## Supported Platforms
* linux/amd64
* linux/arm/v7
* linux/arm64

## Build Commands
```
.\build <psver>
```

_This will connect to the [PowerShell Github Release Repository](https://github.com/PowerShell/PowerShell/releases) to download the release specified in `<psver>`. You must enter the version as it appears on this page._

### Parameters
`<psver>` the PowerShell version. _Required_

### Examples
Build PowerShell version 6.2.2 container
```
.\build 6.2.2
```

Build PowerShell version 7 Preview 2 container
```
.\build 7.0.0-preview.2
```