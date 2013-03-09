module.exports = (editor) ->
  
  editor.fetch = (args) ->
    
    query = JSON.stringify args
    
    jQuery.get "http://#{window.location.hostname}:8080/fetch?args=#{query}", args, (url) ->
      
      editor.image src: url