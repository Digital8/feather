module.exports = (graphicController) ->
  
  {view, graphic, parent} = graphicController
  
  {dom} = view
  
  dom.draggable
    
    drag: ->
      
      graphic.offset =
        left: dom.position().left / parent.width()
        top: dom.position().top / parent.height()
      
      # graphic.relative =
      #   width: dom.width() / parent.width()
      #   height: dom.height() / parent.height()
      
      graphicController.emit 'interact'
      
      graphic.emit 'move'