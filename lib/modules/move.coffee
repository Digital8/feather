module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    console.log 'move'
    graphic.dom.draggable()