module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.scalable = (args) ->
      
      if not args?
        
        graphic.dom.resizable
          handles: 'all'
          minWidth: 100
          minHeight: 100
          resize: ->
            # Feather.quality 'average'
            graphic.emit 'resize'
        
        graphic.dom.find('.ui-resizable-handle').addClass 'ui-handle'
        
        graphic._scale ?= {}
        
        (jQuery '#options-resize').css opacity: 1
      
      if args is 'destroy'
        
        return unless graphic._scale?
        
        graphic.dom.resizable 'destroy'
        
        delete graphic._scale
        
        (jQuery '#options-resize').css opacity: 0.5
    
    graphic.on 'deselect', ->
      graphic.scalable 'destroy'
    
    graphic.on 'select', ->
      return unless editor.kit.active?.key is 'scale'
      
      graphic.scalable()
  
  (jQuery '#options-resize').css opacity: 0.5
  
  editor.kit.on 'activate', ({key}) ->
    return unless key is 'scale'
    (jQuery '#options-resize').fadeIn()
    editor.selected?.scalable()
  
  editor.kit.on 'deactivate', ({key}) ->
    (jQuery '#options-resize').fadeOut()
    editor.selected?.scalable 'destroy'
  
  editor.on 'apply', ({key}) ->
    return unless key is 'scale'
    
    editor.graphics.map (key, graphic) ->
      
      src = editor.operations.scale.operate
        image: graphic.image
        width: graphic.dom.width()
        height: graphic.dom.height()
      
      graphic.image.src = src