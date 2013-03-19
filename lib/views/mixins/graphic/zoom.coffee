module.exports = (graphicController) ->
  
  {editor, graphic, view} = graphicController
  
  zoom = (factor) ->
    
    width = graphic.relative.width * factor
    height = graphic.relative.height * factor
    
    center = [
      graphic.offset.left + (graphic.relative.width  / 2)
      graphic.offset.top  + (graphic.relative.height / 2)
    ]
    
    graphic.offset =
      left: center[0] - (width / 2)
      top: center[1] - (height / 2)
    
    graphic.relative =
      width: width
      height: height
    
    graphic.emit 'zoom'
    graphic.emit 'move'
    graphic.emit 'resize'
  
  editor.ui.on 'zoom', (factor) ->
    zoom factor
  
  graphic.slot.graphics.on 'activate', ->
    # (jQuery '#options-resize').show()
    (jQuery '#options-resize').css opacity: 1
  
  graphic.slot.graphics.on 'deactivate', ->
    # (jQuery '#options-resize').hide()
    (jQuery '#options-resize').css opacity: 0.5