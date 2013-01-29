express = require 'express'
CoffeeScript = require 'coffee-script'
browserify = require 'browserify'

app = express()

app.use express.logger 'dev'

app.use express.static "#{__dirname}/public"

bundle = browserify
  entry: "#{__dirname}/client.coffee"
  watch: on
  debug: on
app.get '/bundle.js', (req, res) ->
  res.set 'Content-Type', 'text/javascript'
  res.send bundle.bundle()

app.get '/', (req, res) ->
  
  console.log 'Feather Deamon client connected'
  
  res.send """
    <html>
      <head>
        <title>feather daemon client</title>
        
        <script src="/jquery.js"></script>
        
        <script src="/socket.io/socket.io.js"></script>
        
        <script src="/bundle.js"></script>
      </head>
      
      <body>
      
      </body>
    </html>
  """

server = app.listen 1337
console.log "Feather Daemon's listening on 1337"

io = (require 'socket.io').listen server

io.sockets.on 'connection', (socket) ->
  
  socket.on 'log', ->
    console.log arguments...
  
  socket.on 'getProject', (key) ->
    console.log 'getProject', arguments...
    
    project = require "./public/fixtures/projects/#{key}"
    
    # console.log 'project', project
    
    socket.emit 'project', project