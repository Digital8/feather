querystring = require 'querystring'

module.exports = (editor) ->
  
  {search, hash} = window.location
  
  editor.config.search = {}
  
  if search.length
    
    editor.config.search = querystring.parse search[1..]