# SOX Player

A image for playing sounds on a host machine.
Comes with a simple HTTP API written in nodejs for playing back audio on demand from a remote process or system.

Designed for use in playing pre-recorded audio notifications for home automation software (openHAB).

## Example

```sh
docker run --device /dev/snd:/dev/snd -v /path/to/soundfiles:/data:ro -p 3859:3859 kosdk/soxplayer:latest
```

## API

You can view the [API documentation here](/soxplayer/APIDOCS.md).

## Setup

You must map the `/dev/snd` device to the container so that the playback audio occurs.

It is recommended that you place this behind a reverse proxy so that you can secure the API.
You can use the `X-FORWARDED-FOR` header to pass through the origin IP.
Check the documentation for your reverse proxy for more information.

## Environment Variables

| Variable  | Type    | Description                                                              |
| --------- | ------- | ------------------------------------------------------------------------ |
| PORT      | Number  | The port to start the API web server on. *Default 3859.*                 |
| LOCATION  | String  | The location in the container of the playback folder. *Default `/data`.* |
| DENY_LIST | Boolean | Disables listing of files in the playback folder. *Default `false`.*     |

## Health Check

This image has a health check which ensures the HTTP server responds and that the playback folder exists.

## Building

Use the [unified build tool](/README.md#building-images).
There are no additional parameters to configure.
