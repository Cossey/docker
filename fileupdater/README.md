# File Updater Container

This container will automatically update a set of files at the specified interval.

## Supported Platforms
* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/386
* linux/amd64
* linux/s390x

## Container Configuration

| Name       | Type    | Description                                                  |
| ---------- | ------- | ------------------------------------------------------------ |
| INTERVAL   | integer | The interval time in minutes. *Required*                     |
| OUTPUTPATH | string  | The output path in the container. *Default: `/fileoutput`*   |
| IGNORESSL  | boolean | Ignore SSL errors (invalid certificates). *Default: `false`* |
| CACERT     | string  | Provides a specific certificate for `https` connections.     |
| URL1       | string  | The URL of the file to download. *Required*                  |
| NAME1      | string  | The name of the file for `URL1`. *Required*                  |
| URL2       | string  | The URL of the file to download.                             |
| NAME2      | string  | The name of the file for `URL2`.                             |

> You can provide multiple files and names using `URL2`, `NAME2`, `URL3`, `NAME3` and so on.

> If `IGNORESSL` and `CACERT` environment variables are provided then `IGNORESSL` takes precedence. Using `IGNORESSL` is not recommended. If you are using a self-signed or custom certificate authority then use the `CACERT` option with the root certificate.

### Usage Examples
Download two images from `http://192.168.1.1` every 5 minutes and name them `image1.png` and `image 2.png` in the host folder `/var/images`:
```
docker run -d \
--name ImageUpdater \
-e INTERVAL=5 \
-e URL1=http://192.168.1.1/files/1.png \
-e URL2=http://192.168.1.1/files/image.png \
-e NAME1=image1.png \
-e NAME2=image\ 2.png \
--mount type=bind,source=/var/images,target=/fileoutput \
kosdk/fileupdater
```

Download a image from a https server  with a self-generated root ca every 2 hours:
```
docker run -d \
-e INTERVAL=120 \
-e URL1=https://192.168.1.250/sslimage.png \
-e NAME1=sslimage.png \
-e CACERT=/certs/ca.pem \
--mount type=bind,source=/var/images,target=/fileoutput \
--mount type=bind,source=/certs,target=/certs,readonly \
kosdk/fileupdater
```

## Building this Image
```
.\build "<ver>"
```
*The above the command uses `buildx` to create the image.*

### Parameters
`<ver>` The version to tag the image as.