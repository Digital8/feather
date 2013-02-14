module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.hideHandles = ->
      graphic.handles.fadeOut 'swift'
    
    graphic.showHandles = ->
      graphic.handles.fadeIn 'swift'
    
    # # save the graphic's container
    # graphic.container = graphic.dom
    
    console.log 'scale'
    graphic.dom.resizable
      handles: 'all'
      minWidth: 100
      minHeight: 100
    
    graphic.handles = graphic.dom.find '> .ui-resizable-handle'
    graphic.handles.addClass 'ui-handle'
    graphic.handles.hide()
    
    #   graphic.dom.hide()
    #   graphic.dom.fadeIn()
    #   graphic.dom.css overflow: 'visible'
    
    graphic.on 'deselect', ->
      graphic.hideHandles()
    
    graphic.on 'select', ->
      return unless editor.kit.active?.key is 'scale'
      graphic.showHandles()
  
  # editor.kit.on 'activate', ({key}) ->
  #   return unless key is 'scale'
    
  #   editor.graphics.map (key, graphic) ->
      
  #     graphic._save = graphic.save()
      
  #     console.log graphic._save
  
  editor.on 'apply', ({key}) ->
    return unless key is 'scale'
    
    editor.graphics.map (key, graphic) ->
      
      src = editor.operations.scale.operate
        image: graphic.image
        width: graphic.dom.width()
        height: graphic.dom.height()
      
      window.open src
      
      graphic.image.src = src