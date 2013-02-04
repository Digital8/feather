Tool = require '../tool'

module.exports = class Scale extends Tool
  
  constructor: (args = {}) ->
    
    super
  
  activate: ->
    
    super
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.showHandles()
  
  deactivate: ->
    
    super
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.hideHandles()
  
  commit: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.hideHandles()