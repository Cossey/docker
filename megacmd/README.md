# Mega.nz megacmd

This is a container for the megacmd tool. Designed with convenience functions, intended to use for backing up data a regular intervals.

## Supported Platforms

* linux/amd64
* linux/386
* linux/arm/v7

## Container Configuration

| Name     | Description                                                                                                 |
| -------- | ----------------------------------------------------------------------------------------------------------- |
| USERNAME | The mega account username. *Required if SESSION not supplied.*                                              |
| PASSWORD | The mega account password. *Required if SESSION not supplied.*                                              |
| SESSION  | The mega login session. *Required if USERNAME and PASSWORD not supplied.*                                   |
| MEGACMD  | The command to pass to the megacmd program. You don't need to prefix the `mega-` to the command. *Required.* |
| INTERVAL | The time in minutes to repeat the command. Leave blank or set to 0 exit immediately.                        |
| BEGIN    | The time in HHMM UTC to first run the command. If not set will run immediately.                             |

> You can add `_FILE` to the end of any environment variable to set the variable from a file. Typically used for secrets.

If the `BEGIN` command is set, then the `INTERVAL` will be set to 1440 (one day) automatically. If you want to override this then set `INTERVAL` to the delay you want (you can also set it to `0` to exit immediately).

For a list of program commands and user guide, visit https://github.com/meganz/MEGAcmd/blob/master/UserGuide.md

## Usage

To run help (one-off)
```
docker run -d \
-e USERNAME=<yourmegausername> \
-e PASSWORD=<yourmegapassword> \
-e MEGACMD=help \
kosdk/megacmd
```

To upload a folder every day from the host machine
```
docker run -d \
-v /backup:/hostpathtofolder
-e SESSION=<sessionid> \
-e INTERVAL=1440
-e MEGACMD="put /backup/* /backup/server/" \
kosdk/megacmd
```

## Session IDs

It is recommended to use the `SESSION_FILE` environment variable to read a session secret from docker secrets/file instead of exposing your username and password.

To generate a session id, you can run the container with following:
```
docker run --rm \
-e USERNAME=<yourusername> \
-e PASSWORD=<yourpassword> \
-e MEGACMD="session" \
kosdk/megacmd
```
You will see the session secret in the output.

## Building this Image

The environment variable `DOCKER_HUB_PROFILE` must be set before you can build using the powershell script as this specifies the docker hub profile to build the image for.

```
.\build <tag>
```
`<tag>` is the tag to apply to the build.

_The above command uses PowerShell and `buildx` to create the image._
