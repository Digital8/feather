module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    graphic.dom.draggable()