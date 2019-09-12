# DuckDNS DNS Updater Container for Linux

This container will keep the specified domains on [DuckDNS](https://www.duckdns.org) updated.

This script was adapted from the [theonemule/docker-dynamic-dns](https://github.com/theonemule/docker-dynamic-dns) repository. It was modified and updated to work with Duck DNS and compiled to run on multiple linux architectures.

> WARNING: This script also does an IP check before each update to DuckDNS. You might get throttled if your interval is set too low.

## Supported Platforms
* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/386
* linux/amd64
* linux/s390x

## Container Configuration
There are 5 environment variables for configuration.

| Name     | Type      | Description                               |
| -------- | --------- | ----------------------------------------- |
| TOKEN    | text      | DuckDNS access token                      |
| DOMAINS  | text      | Comma separated list of domains to update |
| DETECTIP | number    | 1 = Auto detect ip                        |
| IP       | ipaddress | Set the IP address for the domains        |
| INTERVAL | number    | Time in minutes to update                 |

* If `DETECTIP` is not being used then you must set an the `IP` var.
* Setting the `INTERVAL` var to 0 will stop the container when it has updated the DNS. This is so that you can manage scheduling through another system.

## Building this Image
```
.\build "<alpinever>"
```
_The above command uses PowerShell and `buildx` to create the image._

### Parameters
`<alpinever>` The version of alpine linux to build from. _Required_

### Examples
Build the container from alpine version 3.10 base image.
```
.\build "3.10"
```