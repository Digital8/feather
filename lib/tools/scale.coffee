Tool = require '../tool'

module.exports = class Scale extends Tool
  
  activate: ->
    
    super
    
    @editor.selected?.showHandles()
  
  deactivate: ->
    
    super
    
    @editor.selected?.hideHandles()