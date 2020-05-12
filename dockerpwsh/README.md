# Docker inside a Docker Container with Powershell

This is built from the official [docker](https://hub.docker.com/_/docker) image. The only difference is that this also contains Powershell Core (amd64 alpine).

It's recommended that you don't run Docker inside a Docker container unless you know what you're doing or using the `-v /var/run/docker.sock:/var/run/docker.sock` volume mount.