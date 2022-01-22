# DuckDNS DNS Updater

This image will keep the specified domains on [DuckDNS](https://www.duckdns.org) updated.

This script was adapted from the [theonemule/docker-dynamic-dns](https://github.com/theonemule/docker-dynamic-dns) repository.
It was modified and updated to work with Duck DNS and compiled to run on multiple linux architectures.

> WARNING: This script also does an IPv6 check before each update to DuckDNS.
You might get throttled if your interval is set too low.
A failure message will appear if your connection does not support IPv6 but the container will continue to update any domains IPv4 address.

## Supported Platforms
* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/386
* linux/amd64
* linux/s390x
* linux/ppc64le

## Container Configuration
There are 5 environment variables for configuration.
**Bold** items are required.

| Name         | Type      | Description                               |
| ------------ | --------- | ----------------------------------------- |
| **TOKEN**    | text      | DuckDNS access token                      |
| **DOMAINS**  | text      | Comma separated list of domains to update |
| IP           | ipaddress | Set the IP address for the domains        |
| IP6          | ipaddress | Set the IPv6 address for the domains      |
| INTERVAL     | number    | Time in minutes to update                 |

> You can suffix `_FILE` to all the environment variable names above to read these values from a file (secrets).

* If the `INTERVAL` is not set or set to `0` the container will stop when it has updated the IP address.
* The IPv4 and IPv6 will be autodetected unless specified.
* The Domain list does not require the `.duckdns.org` part of the domain.

## Building this Image

Use the unified build tool.
There are no parameters to configure.

## Health check

This image checks to ensure that the duckdns script is running and that www.duckdns.org is resolvable in DNS.