module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    graphic.delete = ->
      
      graphic.emit 'delete'