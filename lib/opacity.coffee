module.exports = (dom, opacity = 0.1) ->
  
  ua = require 'useragent-wtf'
  
  # app.socket.emit 'debug', ua
  
  support = no
  
  if ua.browser is 'msie' and ua.version.major is '8'
    support = no
  
  if support
    dom.css {opacity}
  
  unless support
    dom.css background: 'url(/css/images/mask.png)'