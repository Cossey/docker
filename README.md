# Docker Hub
Dockerfiles and scripts for my Images hosted at https://hub.docker.com/u/kosdk

You can build most of the images using the `build.ps1` powershell script in each folder to build the respective images. Check the sections below for any parameters that you can pass to the builder.

The PowerShell build scripts have a `$tag` variable that you can edit so you can customize the image tag name for your repsitory.

> These build scripts use the experimental `buildx` command in _Docker Desktop 2.0.4.0 or higher_ to build for multiple Linux platforms. You need to enable experimental features. Read more about [this command here](https://docs.docker.com/buildx/working-with-buildx/).

**All these packages support multiple linux architectures including the Raspberry Pi. _You're welcome!_**

## Chocolatey Package Manager **_/choco_**
Supports building packages and pushing them to a Chocolatey Registry in a Linux Container. 

> This image only supports the `choco pack`, `choco new` and `choco push` commands.

Refer to the [readme](choco/README.md) file in the folder for further details.

## PowerShell Core **_/powershellcore_**
Run PowerShell Core in a Linux Container.

Refer to the [readme](powershellcore/README.md) file in the folder for further details.

## ISC DHCP Server **_/dhcpd_**
The ISC DHCP Server running in a Docker Container.

Refer to the [readme](dhcpd/README.md) file in the folder for further details.

## File Updater **_/fileupdater_**
A linux container with a script to update files at set intervals.

Refer to the [readme](fileupdater/README.md) file in the folder for further details.

## DuckDNS Updater Client **_/duckdns_**
A linux container to update your Dynamic DNS with [DuckDNS](www.duckdns.org).

Refer to the [readme](duckdns/README.md) file in the folder for further details.

## Docker in Docker with Powershell
A *amd64 only* container built from the official Docker container that includes Powershell Core.

Refer to the [readme](dockerpwsh/README.md) file in the folder for further details.