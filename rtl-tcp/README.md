# RTL TCP (SDR)

Repository for a docker image that runs the rtl_tcp program.
Originally leveraging the `erben22/rpi-rtlsdr-base` image, this image has been overhauled and runs an instance of the rtl_tcp program.

## Environment Variables

| Variable     | Type    | Description                                               |
| ------------ | ------- | --------------------------------------------------------- |
| DEVICE       | integer | Set the device index. *Default 0*.                        |
| GAIN         | integer | Set the device gain. *Default 0 (auto)*.                  |
| BUFFERS      | integer | Set the number of buffers. *Default 15*.                  |
| LIST_BUFFERS | integer | Max number of linked list buffers to keep. *Default 500*. |
| PPM_ERROR    | integer | PPM Error. *Default 0*.                                   |
| FREQUENCY    | integer | Frequency to tune to (Hz).                                |
| SAMPLE_RATE  | integer | Sample rate (Hz). *Default 2048000 Hz*.                   |
| BIAS_T       | boolean | Enable bias-T on GPIO PIN 0.                              |

> All the variables above also support the `_FILE` suffix to load their values from a file.

## Usage

Run rtl_tcp in a container, exposing connections to it via port 1234.
Using `--privileged` and mapping the `/dev/bus/usb` volume, an RTL dongle is made available to the container.
Clients will be able to connect via port 1234 to the docker hosts's address.

```sh
sudo docker run -d -it -p 1234:1234 --device /dev/bus/usb:/dev/bus/usb kosdk/rtl-tcp
```

## Building this Image

Use the [unified build tool](/README.md#building-images).
There are no additional parameters to configure.

## Health check

This image checks to ensure that the script is running.
