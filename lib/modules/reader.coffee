util = require 'util'

module.exports = (editor) ->
  
  editor.handle = (event) ->
    
    reader = new FileReader
    
    reader.addEventListener 'load', (e) =>
      #editor.image src: reader.result
      
      url = "http://#{window.location.hostname}:8080/upload"
      jQuery.ajax
        url: url
        type: 'POST'
        data: {image: reader.result}
        error: (data) -> console.log "Upload Failed!"
        success: (data) ->
          console.log "Upload Success! #{data.id}"
          editor.image src: data.uri, id: data.id
    
    reader.readAsDataURL event.target.files[0]