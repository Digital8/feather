module.exports = (graphicController) ->
  
  {graphic, editor, view, slotController} = graphicController
  
  {slot} = graphic
  
  scalable = (graphicController) ->
    
    unless args?
      resizable = view.dom.resizable
        handles: 'all'
        minWidth: 100
        minHeight: 100
        resize: ->
          graphic.relative =
            width: view.dom.width() / slotController.view.dom.width()
            height: view.dom.height() / slotController.view.dom.height()
          graphic.emit 'resize'
          
          graphic.offset =
            left: view.dom.position().left / slotController.view.dom.width()
            top: view.dom.position().top / slotController.view.dom.height()
          graphic.emit 'move'
      
      view.dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
      return {
        resizable: resizable
        destroy: ->
          resizable.resizable 'destroy'
      }
  
  graphic.on 'activate', ->
    if editor.kit.active?.key is 'scale'
      graphicController.scalable = scalable graphicController
  graphic.on 'deactivate', ->
    if editor.kit.active?.key is 'scale'
      graphicController.scalable.destroy()
  
  editor.kit.on 'activate', ({key}) ->
    if key is 'scale'
      if graphic.slot.graphics.active is graphic
        graphicController.scalable = scalable graphicController
  
  editor.kit.on 'deactivate', ({key}) ->
    if key is 'scale'
      if graphic.slot.graphics.active is graphic
        graphicController.scalable.destroy()