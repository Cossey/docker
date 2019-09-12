# ISC DHCP Server
The ISC DHCP Server running in a Docker Container.

## Supported Platforms
_Depends on Version and Base Operating System. Debian has the best platform coverage for the latest version:_

* linux/386
* linux/amd64
* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/ppc64le
* linux/s390x

## Versions
This script has a lookup table, as each Operating System release supports a specific version.

Debian
* 4.3.1
* 4.3.5
* 4.4.1

Ubuntu
* 4.3.3
* 4.3.5
* 4.4.1

## Build Commands
```
.\build <ddver> <os>
```

### Parameters
`<ddver>` The ISC DHCPD Version. _Required_  
`<os>` The Base OS Image. Either `debian` (default) or `ubuntu`. _Optional_

### Examples
Build version 4.3.5 on Debian
```
.\build 4.3.5
```

Build version 4.4.1 on Ubuntu
```
.\build 4.4.1 ubuntu
```