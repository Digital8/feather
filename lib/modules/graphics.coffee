Graphic = require '../graphic'
Library = require '../core/library'

module.exports = (editor) ->
  
  editor.on 'ui', (key, args) ->
    
    if key is 'image'
      console.log 'ui', 'image'
      editor.image args
  
  editor.image = ({src, id}) ->
    
    image = new Image
    
    image.onload = =>
      
      return if image._loaded
      
      image._loaded = true
      
      editor.emit 'image', image, id
    
    image.src = src
  
  editor.graphics = new Library type: Graphic
  
  editor.on 'image', (image, id) =>
    
    graphic = editor.graphics.new image: image, editor: editor, id: id
    
    editor.projects.active.surface.element.append graphic.dom
    
    # graphic.dom.find('img').css '-webkit-transition': 'all 0.75s'
    
    editor.emit 'graphic', graphic
  
  # editor.graphics.on 'remove', (graphic) ->
  
  #   console.log 'remove', graphic