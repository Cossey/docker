// Copyright © 2022 Stewart Cossey. BSD 3-Clause licensed.
// This file checks to ensure that the healthcheck endpoint returns a 200 status code.

http = require("http");

var options = {  
    host : "localhost",
    port : process.env.PORT || 3859,
    timeout : 2000,
    path : "/status",
};

var request = http.request(options, (res) => {  
    console.log(`STATUS: ${res.statusCode}`);
    if (res.statusCode == 200) {
        process.exit(0);
    }
    else {
        process.exit(1);
    }
});

request.on('error', function(err) {  
    console.log('ERROR');
    process.exit(1);
});

request.end();  
