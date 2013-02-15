module.exports = (editor) ->
  
  editor.load = ->
    
    save = localStorage.project
    
    data = JSON.parse save
    
    for key, save of data.graphics
      
      # graphic = editor.graphics.new()
      
      editor.image src: save.src