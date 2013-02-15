module.exports = (editor) ->
  
  editor.load = ->
    
    save = localStorage.project
    
    data = JSON.parse save
    
    for key, save of data.graphics
      
      image = new Image
      graphic = editor.graphics.new id: key, image: image, editor: editor
      editor.surface.element.append graphic.dom
      editor.emit 'graphic', graphic
      graphic.restore save