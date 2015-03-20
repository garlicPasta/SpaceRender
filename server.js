var express = require('express')
, http = require('http')
, path = require('path')
, reload = require('reload')

var app = express()

    var publicDir = __dirname

    app.set('port', process.env.PORT || 3000)
    app.use(express.static(path.join(__dirname,'build'))) //should cache static assets 

    app.get('/', function(req, res) {
        res.sendfile(path.join(publicDir, 'index.html'))
    })

var server = http.createServer(app)

    //reload code here 
reload(server, app)

    server.listen(app.get('port'), function(){
        console.log("Web server listening on port " + app.get('port'));
    });
