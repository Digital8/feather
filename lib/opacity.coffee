module.exports = (dom, opacity = 0.1) ->
  
  ua = require 'useragent-wtf'
  
  app.socket.emit 'debug', ua
  
  support = yes
  
  if support
    
    dom.css {opacity}
  
  unless support
    
    dom.css
      background: 'url(/css/images/mask.png)'