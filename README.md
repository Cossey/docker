# Docker Hub

Dockerfiles and scripts for my Images hosted at <https://hub.docker.com/u/kosdk>.

You can build most of the images using the `build.ps1` powershell script in each folder to build the respective images.
Check the sections below for any parameters that you can pass to the builder.

The PowerShell build scripts have a `$tag` variable that you can edit so you can customize the image tag name for your repository.
There is also a environment variable called `DOCKER_HUB_PROFILE` which contains the profile repository that these images are hosted on.
The `DOCKER_HUB_PROFILE` must be set before using the `build.ps1` scripts.

> These build scripts use the experimental `buildx` command in _Docker Desktop 2.0.4.0 or higher_ to build for multiple Linux platforms.
You need to enable experimental features.
Read more about [this command here](https://docs.docker.com/buildx/working-with-buildx/).

**All these packages support multiple linux architectures including the Raspberry Pi.
_You're welcome!_**

## Building Images

You can build them using the `build.ps1` in their folder or for packages marked as UBT, building of the images is done via the unified build tool.
Located in the repository root, the UBT `build.ps1` can build all compatible packages.

The environment variable `DOCKER_HUB_PROFILE` must be set before you can build as this specifies the docker hub profile to build the image for.

| Parameter   | Type   | Description                                                                        |
| ----------- | ------ | ---------------------------------------------------------------------------------- |
| -image      | string | The image to build. **Required.**                                                  |
| -output     | string | The docker build output type (`load`, `push`, `folder`).                           |
| -outputpath | string | The output path when the output type is `folder`.                                  |
| -version    | string | Specifies a tag for the image. **Required when image does not provide a version.** |

Check the readme for each image to see if there are any additional parameters to pass to build tool for the image.

### Build Example

```pwsh
.\build soxplayer -output load -version 123
```

## Images

UBT = Build using the *Unified Build Tool*.

### [Web Service Discovery host daemon](wsdd/)

[Readme](wsdd/README.md) | UBT

Allows legacy samba shares to be discovered by Windows 10 version 1511 and higher.
Useful when hosting samba in docker.
Runs on Python 3.

### [Chocolatey Package Manager](choco/)

[Readme](choco/README.md)

Supports building packages and pushing them to a Chocolatey Registry in a Linux Container.

> This image only supports the `choco pack`, `choco new` and `choco push` commands.

### [PowerShell Core](powershellcore/)

[Readme](powershellcore/README.md)

Run PowerShell Core in a Linux Container.

### [ISC DHCP Server](dhcpd/)

[Readme](dhcpd/README.md)

The ISC DHCP Server running in a Docker Container.

### [RTL-SDR TCP Server](rtl-tcp/)

[Readme](rtl-tcp/README.md) | UBT

The RTL_TCP tool running in a Docker container.

### [Mega.nz megacmd](megacmd/)

[Readme](megacmd/README.md) | UBT

megacmd with some convenience functions to help with backing up files.

### [Sox Player](soxplayer/)

[Readme](soxplayer/README.md) | [BSD 3-Clause](soxplayer/LICENCE) | UBT

Runs sox player in a container with a simple HTTP web API to play/stop audio on demand.

### [File Backup](filebackup/)

[Readme](filebackup/README.md) | [BSD 3-Clause](filebackup/LICENCE) | UBT

A linux container with a script to update files at set intervals with support for many platforms.

### [File Updater](fileupdater/)

[Readme](fileupdater/README.md) | [BSD 3-Clause](fileupdater/LICENCE) | UBT

A linux container with a script to update files at set intervals with support for many platforms.

### [DuckDNS Updater Client](duckdns/)

[Readme](duckdns/README.md) | [BSD 3-Clause](duckdns/LICENCE) | UBT

A linux container to update your Dynamic DNS with [DuckDNS](www.duckdns.org) with support for many platforms.

### [Docker in Docker with Powershell](dockerpwsh/)

[Readme](dockerpwsh/README.md)

A *amd64 only* container built from the official Docker container that includes Powershell Core.
