module.exports = (dom, opacity = 0.1) ->
  
  ua = require 'useragent-wtf'
  
  app.socket.emit 'debug', au