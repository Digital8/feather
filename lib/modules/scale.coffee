module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.scalable = (args) ->
      
      if not args?
        
        graphic.data.scale =
          before: graphic.save().css
        
        graphic.handleScale = ->
          
          now = graphic.save().css
          {before} = graphic.data.scale
          
          graphic.data.scale.x = now.width / before.width
          graphic.data.scale.y = now.height / before.height
          
          graphic.emit 'resize'
        
        graphic.dom.resizable
          handles: 'all'
          minWidth: 100
          minHeight: 100
          resize: ->
            graphic.handleScale()
        
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
    (jQuery '#options-resize').delay(666).fadeIn()
    editor.selected?.scalable()
  
  editor.kit.on 'deactivate', ({key}) ->
    (jQuery '#options-resize').fadeOut()
    editor.selected?.scalable 'destroy'
  
  editor.on 'apply', ({key}) ->
    return unless key is 'scale'
    
    editor.graphics.map (key, graphic) ->
      
      graphic.scale[0] *= graphic.data.scale.x
      graphic.scale[1] *= graphic.data.scale.y
      
      # src = editor.operations.scale.operate
      #   image: graphic.image
      #   width: graphic.dom.width()
      #   height: graphic.dom.height()
      
      # graphic.image.src = src