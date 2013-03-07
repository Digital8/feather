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
    
    # editor.surface.element.append graphic.dom
    
    editor.surfaces.map (key, surface) =>
      
      surface.element.append graphic.dom
    
    graphic.dom.find('img').css '-webkit-transition': 'all 0.75s'
    
    # graphic.dom.css '-webkit-transition': 'width 0.125s, height 0.125s, box-shadow 0.33s, left 0.125s, top 0.125s'
    
    editor.emit 'graphic', graphic
  
  editor.graphics.on 'remove', (graphic) ->
    
    console.log 'remove', graphic

# @graphics.on 'add', (graphic) =>
  
#   @kit.tools.get('filter').push()
  
#   setTimeout =>
#     Feather.quality()
#     @kit.tools.get('zoom').fit graphic
#     @augmentations.get('select').deselect()
#     @kit.tools.get('filter').push()
#   , 111