Tool = require '../tool'

module.exports = class Scale extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    (jQuery '#zoom-out').click =>
    
    @kit.editor.ui.stage.click =>
      
      for key, graphic of @kit.editor.graphics.objects
        graphic.hideHandles()
    
    @kit.editor.on 'graphic', (graphic) =>
      
      graphic.dom.click (event) =>
        
        return unless @kit.active is this
        
        event.stopPropagation()
        
        for key, _graphic of @kit.editor.graphics.objects
          _graphic.hideHandles()
        
        graphic.showHandles()
  
  activate: ->
    
    super
    
    (jQuery '#options-resize').fadeIn()
    
    # for key, graphic of @kit.editor.graphics.objects
      
    #   graphic.showHandles()
  
  deactivate: ->
    
    super
    
    (jQuery '#options-resize').fadeOut()
    
    # for key, graphic of @kit.editor.graphics.objects
      
    #   graphic.hideHandles()
  
  commit: ->
    
    # for key, graphic of @kit.editor.graphics.objects
      
    #   graphic.hideHandles()