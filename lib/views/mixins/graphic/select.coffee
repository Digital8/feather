module.exports = (graphicController) ->
  
  {graphic, editor, view} = graphicController
  
  {slot} = graphic
  
  bringToTop = (graphicController) ->
    slot.z += 1
    graphic.z = slot.z
    graphic.emit 'z'
  
  graphicController.on 'interact', ->
    graphic.slot.graphics.activate graphic
  
  graphic.on 'z', ->
    view.dom.css 'z-index': graphic.z
  
  border = ({color, width}) ->
    
    return border: "#{color} #{width}px solid"
  
  select = (graphicController) ->
    
    bringToTop graphicController
    
    view.dom.find('img').css (border color: 'blue', width: 3)
  
  deselect = (graphicController) ->
    view.dom.find('img').css (border color: 'blue', width: 0)
  
  slot.graphics.on 'activate', (_graphic) ->
    if _graphic is graphic
      select graphicController
  
  slot.graphics.on 'deactivate', (_graphic) ->
    if _graphic is graphic
      deselect graphicController
  
  # editor.ui.on 'deselect', (event) ->
  #   slot.graphics.deactivate()