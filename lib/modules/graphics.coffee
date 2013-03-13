Graphic = require '../graphic'
Library = require '../core/library'

module.exports = (editor) ->
  
  editor.graphics = new Library type: Graphic
  
  editor.on 'image', (image) =>
    
    editor.graphics.new
      image: image
      editor: editor