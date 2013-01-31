Tool = require '../tool'

module.exports = class Scale extends Tool
  
  constructor: (args = {}) ->
    
    super
  
  activate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.showHandles()
  
  deactivate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.hideHandles()