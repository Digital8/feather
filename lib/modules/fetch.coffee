module.exports = (editor) ->
  
  editor.fetch = (args) ->
    
    query = JSON.stringify args
    
    jQuery.get "http://#{window.location.hostname}:8080/fetch?args=#{query}", args, (url) ->
      
      # console.log 'GET', '/fetch', arguments
      
      editor.image src: url