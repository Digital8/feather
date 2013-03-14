querystring = require 'querystring'

parse = require '../parse'

module.exports = (editor) ->
  
  {search, hash} = window.location
  
  editor.ENV ?= {}
  
  if search.length
    
    for key, value of (querystring.parse search[1..])
      
      editor.ENV[key] = parse value