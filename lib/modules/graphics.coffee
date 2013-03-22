Graphic = require '../graphic'
Library = require '../core/library'

module.exports = (editor) ->
  
  editor.graphics = new Library type: Graphic
  
  editor.on 'image', ({image, width, height}) =>
    
    editor.graphics.new
      image: image
      width: width
      height: height
      editor: editor