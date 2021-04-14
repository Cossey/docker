# Web Service Discovery host daemon
Repository for a docker image that executes the wsdd python 3 script. Useful for systems running samba containers.
Web Service Discovery host daemon is a script maintained at [christgau/wsdd](https://github.com/christgau/wsdd).

## Dockerfile Details

`ENTRYPOINT` launches shell script `start.sh` that then passes script parameters via environment variables to the python script. Uses alpine image, and APKs python3. Copies the files over and `chmod`s the shell script.

## Building

The `build.ps1` powershell script builds the image for amd64, arm and arm64 using `buildx`. It will also check the `wsdd.py` file for the current version number and use that for the tag as well as `latest`.

## Usage

You can run this without any parameters, ensuring that the following ports are open:
* 3702 UDP
* 5357 TCP

You can also specify the environment variables below to configure the script.

## Environment Variables
Passes configuration to the `wsdd.py` script. For details, see the [repository readme](https://github.com/christgau/wsdd/blob/master/README.md).

| Variable | Data Type | Description | Error |
| - | - | - | - |
| HOST_NAME | String | Override the host name wsdd uses during discovery. By default the machine's host name is used (look at hostname(1)). Only the host name part of a possible FQDN will be used in the default case. | Exit Code `10` when invalid host name. |
| WORKGROUP | String | By default wsdd reports the host is a member of a workgroup rather than a domain (use the -d/--domain option to override this). With -w/--workgroup the default workgroup name can be changed. The default work group name is WORKGROUP. | Exit Code `15` when invalid workgroup name. |
| DOMAIN | String | Assume that the host running wsdd joined an ADS domain. This will make wsdd report the host being a domain member. It disables workgroup membership reporting. | Exit Code `15` when invalid domain name. |
| PRESERVE_CASE | Boolean | Preserve the hostname as it is. Without this option, the hostname is converted as follows. For workgroup environments (see -w) the hostname is made upper case by default. Vice versa it is made lower case for usage in domains (see -d). | |
| NO_HTTP | Boolean | Do not service http requests of the WSD protocol. This option is intended for debugging purposes where another process may handle the Get messages. | |
| NO_SERVER | Boolean | Disable host operation mode which is enabled by default. The host will not be discovered by WSD clients when this flag is provided. | |
| IP4_ONLY | Boolean | Restrict to the given address family. If both options are specified no addresses will be available and wsdd will exit. | |
| IP6_ONLY | Boolean | Restrict to the given address family. If both options are specified no addresses will be available and wsdd will exit. | |
| HOP_LIMIT | Number | Set the hop limit for multicast packets. The default is 1 which should prevent packets from leaving the local network segment. | Exit Code `20` when not a number. |
| DISCOVERY_MODE | Boolean | Enable discovery mode to search for other WSD hosts/servers. Found servers are printed to stdout with INFO priority. The server interface (see -l option) can be used for a programatic interface. | |
| UUID | UUID | The WSD specification requires a device to have a unique address that is stable across reboots or changes in networks. In the context of the standard, it is assumed that this is something like a serial number. wsdd uses the UUID version 5 with the DNS namespace and the host name of the local machine as inputs. Thus, the host name should be stable and not be modified. | Exit Code `30` when not a valid UUID. |

> Boolean variables can be set to anything (non-empty) to use the selected option.