# API Documentation

The HTTP API is simple and uses `GET` requests.
URL query strings are used when there are parameters required for an endpoint.

V1 Endpoints: `http://<server>/api/v1`

| Name           | Endpoint | Description                       |
| -------------- | -------- | --------------------------------- |
| [Play](#play) | /play    | Playback a file                   |
| [Stop](#stop) | /stop    | Stop playback                     |
| [List](#list) | /list    | List files in the playback folder |

## Play

`/api/v1/play`

Playback a file from the playback folder.

### Query Strings

| Key | Type   | Description           |
| --- | ------ | --------------------- |
| f   | string | File name to playback |
| v   | number | Volume factor         |

### Responses

| HTTP Code | Name              | Description                                   |
| --------- | ----------------- | --------------------------------------------- |
| 202       | Success           | Playback initiated                            |
| 400       | Missing Parameter | The `f` query string was not provided         |
| 404       | Not Found         | The file was not found in the playback folder |
| 406       | Not allowed       | The file query string had an invalid string   |

### Example

`http://host:3859/api/v1/play?f=test.mp3&v=0.8`

## Stop

`/api/v1/stop`

Immediately stops playback.

### Responses 

| HTTP Code | Name              | Description                                   |
| --------- | ----------------- | --------------------------------------------- |
| 202       | Success           | Stopped                                       |

## List

`/api/v1/list`

Lists the files in the playback folder.
The files are listed and separated by linux line feed.

> This API endpoint can be disabled using the `DENY_LIST` environment variable.

### Responses

| HTTP Code | Name              | Description                                   |
| --------- | ----------------- | --------------------------------------------- |
| 200       | Success           | Displays list of files in the playback folder |
| 403       | Forbidden         | Listing is disabled via `DENY_LIST`           |
| 500       | Error             | Cannot enumerate files (Directory not found)  |

