Tool = require '../tool'

module.exports = class Crop extends Tool
  
  constructor: (args = {}) ->
    
    super
  
  activate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.showCrop()
  
  deactivate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.hideCrop()