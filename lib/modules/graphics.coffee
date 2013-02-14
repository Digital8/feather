Graphic = require '../graphic'
Library = require '../core/library'

module.exports = (editor) ->
  
  editor.on 'ui', (key, args) ->
    
    if key is 'image'
      console.log 'ui', 'image'
      editor.image args
  
  editor.on 'image', ->
    console.log arguments
  
  editor.image = ({src}) ->
    console.log 'image'
    
    image = new Image
    
    image.onload = =>
      
      return if image._loaded
      
      image._loaded = true
      
      editor.emit 'image', image
    
    image.src = src

  editor.graphics = new Library type: Graphic

  editor.on 'image', (image) =>
    graphic = editor.graphics.new image: image, editor: editor
    editor.surface.element.append graphic.dom
    editor.emit 'graphic', graphic

# @graphics.on 'add', (graphic) =>
  
#   @kit.tools.get('filter').push()
  
#   setTimeout =>
#     Feather.quality()
#     @kit.tools.get('zoom').fit graphic
#     @augmentations.get('select').deselect()
#     @kit.tools.get('filter').push()
#   , 111

# image: (src) ->
  
#   image = new Image
  
#   image.onload = =>
    
#     return if image._loaded
    
#     image._loaded = true
    
#     @emit 'image', image
  
#   image.src = src