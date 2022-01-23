# File Updater Container

This container will automatically update a set of files at the specified interval.
Will output how long each download and cycle takes to complete.

## Supported Platforms

* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/386
* linux/amd64
* linux/s390x
* linux/ppc64le

## Container Configuration

**Bold** denotes required Environment Variables.

| Name       | Type    | Description                                                            |
| ---------- | ------- | ---------------------------------------------------------------------- |
| INTERVAL   | integer | The interval time in minutes. If `0` then only run once (default).     |
| OUTPUTPATH | string  | The output path in the container (default `/fileoutput`).              |
| BEGIN      | integer | The time in HHMM UTC when to first start the script.                   |
| IGNORESSL  | boolean | Ignore SSL errors (invalid certificates).                              |
| CACERT     | string  | File location for the certificate to use for `https` connections.      |
| **URL1**   | string  | The URL of the file to download.                                       |
| NAME1      | string  | The name of the file for `URL1`.                                       |
| URL2       | string  | The URL of the file to download.                                       |
| NAME2      | string  | The name of the file for `URL2`.                                       |

You can provide multiple files and names using `URL2`, `NAME2`, `URL3`, `NAME3` and so on. If a file doesn't have a `NAME` set then the file name provided by the remote server will be used.

> You can suffix  `_FILE` to the end of any environment variable to set the variable from a file (ie `URL1_FILE`).

> If `IGNORESSL` and `CACERT` environment variables are provided then `IGNORESSL` takes precedence. Using `IGNORESSL` is not recommended. If you are using a self-signed or custom certificate authority then use the `CACERT` option with the root certificate path (must be volume mapped into the container).

### Usage Examples

Download two images every 5 minutes and name them `image1.png` and `image 2.png` in the host folder `/var/images`:

```sh
docker run -d \
--name ImageUpdater \
-e INTERVAL=5 \
-e URL1=http://example.com/files/1.png \
-e URL2=http://example.com/files/image.png \
-e NAME1=image1.png \
-e NAME2=image\ 2.png \
--mount type=bind,source=/var/images,target=/fileoutput \
kosdk/fileupdater
```

Download a image from a https server with a self-generated root ca every 2 hours:

```sh
docker run -d \
-e INTERVAL=120 \
-e URL1=https://example.org/sslimage.png \
-e CACERT=/certs/ca.pem \
--mount type=bind,source=/var/images,target=/fileoutput \
--mount type=bind,source=/certs,target=/certs,readonly \
kosdk/fileupdater
```

Download a file once

```sh
docker run -d \
-e URL1=https://example.com/file.pdf \
--mount type=bind,source=/home/user,target=/fileoutput \
kosdk/fileupdater
```

Download file every day at 12 pm UTC

```sh
docker run -d \
-e INTERVAL=1440 \
-e BEGIN=1200 \
-e URL1=http://example.net/dailyupdate.zip \
--mount type=bind,source=/home/update,target=/fileoutput \
kosdk/fileupdater
```

## Building this Image

Use the [unified build tool](/README.md#building-images).
There are no additional parameters to configure.

## Health check

This image checks to ensure that the script is running.
