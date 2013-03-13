querystring = require 'querystring'

parse = require '../parse'

module.exports = (editor) ->
  
  {search, hash} = window.location
  
  editor.config.search = {}
  
  if search.length
    
    editor.config.search = querystring.parse search[1..]
    
    for key, value of editor.config.search
      
      editor.config.search[key] = parse value