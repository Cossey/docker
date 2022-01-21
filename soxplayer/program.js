// Copyright © 2022 Stewart Cossey. BSD 3-Clause licensed.
// This file hosts a simple web server that executes sox playback of a sound file.
// Version: 1.0

http = require('http');
fs = require('fs');
url = require('url');
AudioPlayer = require('sox-play');

// Environment variables
var port = process.env.PORT || 3859;
var location = process.env.LOCATION || '/data';
var noList = process.env.DENY_LIST || '';
var player;

var srv = http.createServer(function (req, res) {
    var uri = new URL(req.url, "http://localhost");
    var remoteIP = req.headers['x-forwarded-for']?.split(',').shift() || req.socket?.remoteAddress;
    var isLocal = (req.socket.localAddress === req.socket.remoteAddress);

    switch (uri.pathname) {
        case '/favicon.ico':
            res.writeHead(404);
            break;
        case '/status':
            if (isLocal) {
                if (fs.existsSync(location)) {
                    res.writeHead(200);
                } else {
                    res.writeHead(500);
                }
            } else {
                console.warn(`${remoteIP}: Tried to access status`);
                res.writeHead(404);
            }
            break;
        case '/api/v1/stop':
            if (player) {
                player.stopHard();
                console.log(remoteIP + ": Stop Playback");
            }
            res.writeHead(202);
            break;
        case '/api/v1/play':
            var params = uri.searchParams;
            var file = params.get("f");
            var volume = params.get("v");

            if (file != null) {
                if (file.indexOf("./") === -1) {
                    var fullLocation = location + "/" + file;
                    if (fs.existsSync(fullLocation)) {
                        var params = [];
                        if (volume != null && !isNaN(volume)) {
                            params = ["vol", volume.toString()];
                            info = " | Vol " + volume;
                        }
                        player = new AudioPlayer({ file: fullLocation, args: params });
                        
                        console.log(remoteIP + ": Play " + file + info);
                        player.play();
                        res.writeHead(202);
                    } else {
                        res.writeHead(404);
                        res.write("File not found");
                        console.error(remoteIP + ": Play " + file + " - Error: File not found");
                    }
                } else {
                    res.writeHead(406);
                    res.write("Not allowed './' in the request.");
                    console.error(remoteIP + ": Play " + file + " - Error: Not allowed './' in the request.");
                }
            } else {
                res.writeHead(400);
                console.error(remoteIP + ": Play - Error: No file specified");
            }
            break;
        case '/api/v1/list':
            if (noList.toLowerCase() !== "true") {
                try {
                    res.writeHead(200);
                    fs.readdirSync(location).forEach(file => {
                        res.write(file + "\n");
                    });
                    console.log(remoteIP + ": List files");
                } catch (e) {
                    res.writeHead(500);
                    if (e.errno == -4058) {
                        console.error(remoteIP + ": List files - Error: Directory not found");
                        res.write("Directory not found");
                    } else {
                        console.log(remoteIP + ": List files - Error: " + e);
                        res.write("Internal server error");
                    }
                }
            } else {
                res.writeHead(403);
                res.write("Listing the files is disabled");
                console.error(remoteIP + ": List files - Error: Listing the files is disabled");
            }
            break;
        default:
            console.error(remoteIP + ": Unknown request: " + uri.pathname);
            res.writeHead(404);
    }
    res.end();
})

// Create the listening socket
srv.listen(port, () => {
    console.log("Running HTTP server on port " + port);
});