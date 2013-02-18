module.exports = (editor) ->
  
  editor.fetch = (args) ->
    
    query = JSON.stringify args
    
    jQuery.get "http://wallcreations.digital8.com.au:30000//fetch?args=#{query}", args, (url) ->
      
      # console.log 'GET', '/fetch', arguments
      
      editor.image src: url