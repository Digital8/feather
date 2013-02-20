module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.scalable = (args) ->
      
      if not args?
        
        graphic.dom.resizable
          handles: 'all'
          minWidth: 100
          minHeight: 100
          resize: ->
            Feather.quality 'average'
        
        graphic.dom.find('.ui-resizable-handle').addClass 'ui-handle'
        
        graphic._scale ?= {}
      
      if args is 'destroy'
        
        return unless graphic._scale?
        
        graphic.dom.resizable 'destroy'
        
        delete graphic._scale
    
    graphic.on 'deselect', ->
      graphic.scalable 'destroy'
    
    graphic.on 'select', ->
      return unless editor.kit.active?.key is 'scale'
      
      graphic.scalable()
  
  editor.kit.on 'activate', ({key}) ->
    return unless key is 'scale'
    editor.selected?.scalable()
  
  editor.kit.on 'deactivate', ({key}) ->
    editor.selected?.scalable 'destroy'
  
  editor.on 'apply', ({key}) ->
    return unless key is 'scale'
    
    editor.graphics.map (key, graphic) ->
      
      src = editor.operations.scale.operate
        image: graphic.image
        width: graphic.dom.width()
        height: graphic.dom.height()
      
      graphic.image.src = src