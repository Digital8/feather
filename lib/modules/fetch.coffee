module.exports = (editor) ->
  
  editor.fetch = (args) ->
    
    query = JSON.stringify args
    
    jQuery.get "http://wallcreations.digital8.com.au:8080/fetch?args=#{query}", args, (url) ->
      
      # console.log 'GET', '/fetch', arguments
      
      editor.image src: url