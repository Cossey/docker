# File Backup Container

This container will automatically backup a set of files at the specified interval.
Will output how long each copy and cycle takes to complete and will put copied files into a single tar file.

> Everytime this executes the old backup filename specified will be deleted.

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
| OUTPUTPATH | string  | The output path in the container (default `/output`).                  |
| BEGIN      | integer | The time in HHMM UTC when to first start the script.                   |
| RECURSIVE  | boolean | Recurse subfolders when copying.                                       |
| OUTPUTFILE | string  | The output compressed file.                                            |
| TEMPPATH   | string  | The temporary folder to process and compress all files/folders.        |
| POSTSCRIPT | string  | Will run a script when the compress task has completed.                |
| **PATH1**  | string  | The path of the file or folder to backup.                              |
| PATH2      | string  | The path of the file to folder to backup.                              |
| DEST1      | string  | The destination folder of the file or folder to backup.                |
| DEST2      | string  | The destination folder of the file or folder to backup.                |

You can provide multiple files or destinations using `PATH1`, `DEST1`, `PATH2`, `DEST2` and so on.
`DEST` are optional and if not provided will copy to the root directory of the tar archive.

> You can suffix  `_FILE` to the end of any environment variable to set the variable from a file (ie `PATH1_FILE`).

## Post Script

You can run a script after the compression of files has taken place to do further actions.
The script will have both `OUTPUTPATH` and `OUTPUTFILE` environment variables passed to it so you can do further processing.

## Building this Image

Use the [unified build tool](/README.md#building-images).
There are no additional parameters to configure.

## Health check

This image checks to ensure that the script is running.
