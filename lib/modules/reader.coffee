# util = require 'util'

# module.exports = (editor) ->
  
#   editor.handle = (event) ->
    
#     reader = new FileReader
    
#     reader.addEventListener 'load', (e) =>
      
#       #editor.image src: reader.result
      
#       url = "http://#{window.location.hostname}:8080/upload"
#       window.username ?= 'local.localhost.local'
      
#       jQuery.ajax
#         url: url
#         type: 'POST'
#         data: {image: reader.result, username: window.username}
        
#         error: (data) ->
#           editor.debug "Upload Failed!"
        
#         success: (data) ->
#           editor.debug "Upload Success! #{data.id}"
#           editor.image src: data.uri, id: "#{window.username}_#{data.id}"
    
#     reader.readAsDataURL event.target.files[0]