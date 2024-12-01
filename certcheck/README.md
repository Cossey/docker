# Certificate Checker

This is a container for the certificate checker tool.
This tool will check certificates on a regular basis and send notifications close to expiry.

## Supported Platforms

* linux/arm/v6
* linux/arm/v7
* linux/arm64
* linux/386
* linux/amd64
* linux/s390x
* linux/ppc64le

## Container Configuration

| Name        | Type    | Description                                                                                                 |
| ----------- | ------- |------------------------------------------------------------------------------------------------------------ |
| APP_TOKEN   | Hash    | The Pushover Application Token. *Required.*                                                                 |
| USER_TOKEN  | Hash    | The Pushover User or Group Token. *Required.*                                                               |
| HOST_SYSTEM | String  | The name of the host running the script so that each instance can be identified. *Required.*                |
| INTERVAL    | Integer | The time in minutes to repeat the command. Leave blank or set to 0 exit immediately.                        |
| BEGIN       | Integer | The time in HHMM UTC to first run the command. If not set will run immediately.                             |
| WARNDAYS    | Integer | The days ahead to warn of certificate/crl expiry.                                                           |
| FILE1       | String  | The path to the certificate or revocation list file to check.                                               |
| NAME1       | String  | The name of this certificate or revocation list.                                                            |
| CRL1        | Boolean | Set to `Y` to treat `FILE1` as a Certificate Revocation List otherwise Certificate.                         |
| FILE2       | String  | The path to the certificate or revocation list file to check.                                               |
| NAME2       | String  | The name of this certificate or revocation list.                                                            |
| CRL2        | Boolean | Set to `Y` to treat `FILE2` as a Certificate Revocation List otherwise Certificate.                         |

You can provide multiple files and names using `FILE2`, `NAME2`, `CRL2`, `FILE3`, `NAME3`, `CRL3` and so on.
If a file doesn't have a `NAME` set then the file name provided by the remote server will be used.

> You can suffix `_FILE` to the end of any environment variable to set the variable from a file.
Typically used for secrets or reading from a physical file on disk.

If the `BEGIN` command is set, then the `INTERVAL` will be set to 1440 (one day) automatically.
If you want to override this then set `INTERVAL` to the delay you want (you can also set it to `0` to exit immediately).

## Example Usage

tbd

## Running standalone

You can run this standalone on embedded systems by copying the `cclib.sh` and then using `ccerts.sh` script as a template.
If you need to run this periodically, then execute this as a cronjob.  

The `check_cert` must be specified for each certificate you want to check.
You can also use `check_crl` to check certificate revocation lists are close to expiry.

## Building this Image

Use the [unified build tool](/README.md#building-images).
There are no additional parameters to configure.
