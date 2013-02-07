Tool = require '../tool'

module.exports = class Scale extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'graphic', (graphic) =>
      
      graphic.on 'deselect', ->
        graphic.hideHandles()
      
      graphic.on 'select', =>
        return unless @kit.active is this
        graphic.showHandles()
  
  activate: ->
    
    super
    
    (jQuery '#options-resize').fadeIn()
    
    @editor.augmentations.get('select')?.selected?.showHandles()
  
  deactivate: ->
    
    super
    
    (jQuery '#options-resize').fadeOut()
    
    @editor.augmentations.get('select')?.selected?.hideHandles()
  
  commit: ->
    
    super