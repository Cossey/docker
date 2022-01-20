# Sox Player

A image for playing sounds on a host machine.
Comes with a simple HTTP API written in nodejs for playing back audio on demand from a remote process or system.

Designed for use in playing pre-recorded audio notifications for home automation software (openHAB).

## Example

`docker run --device /dev/snd:/dev/snd -v /path/to/soundfiles:/data:ro -p 3859:3859 kosdk/soxplayer:latest`

# Setup

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

# API

The HTTP API is simple and uses `GET` requests.

## `/api/v1/play`

Playback a file from the playback folder.

Expects a `f` query with the name of the file.
Also supports a `v` query will the volume factor.

### Responses

* HTTP `202`: When playback has successfully initiated.
* HTTP `404`: When the playback file specified in the `f` query could not be found.
* HTTP `406`: When theres a `./` specified in the `f` query (not allowed).
* HTTP `400`: When the `f` query was not provided.

### Example

`http://host:3859/api/v1/play?f=test.mp3&v=1`

## `/api/v1/stop`

Immediately stops playback.

### Responses 

* HTTP `202`: Stop acknoledgement.

## `/api/v1/list`

Lists the files in the playback folder.

> This API endpoint can be disabled using the `DENY_LIST` environment variable.

### Responses

* HTTP `200`: With a List of files in the playback folder seperated by a line feed.
* HTTP `500`: When it cannot enumerate files (ie Directory not found).
* HTTP `403`: When listing is disabled via the `DENY_LIST` environment variable.

# Health Check

This image has a health check which ensures the HTTP server responds and that the playback folder exists.

# Building

Use the build.ps1 script to build the file.
Make sure you have the `DOCKER_HUB_PROFILE` environment variable set.

> This script will check the `program.js` file for the Version comment to set the correct tag.