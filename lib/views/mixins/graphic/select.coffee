module.exports = (graphicController) ->
  
  {graphic, editor} = graphicController
  
  {slot} = graphic
  
  bringToTop = (graphicController) ->
    slot.z += 1
    graphic.z = slot.z
    graphic.emit 'z'
  
  graphicController.on 'interact', ->
    graphic.slot.graphics.activate graphic
  
  graphic.on 'z', ->
    graphicController.view.dom.css 'z-index': graphic.z
  
  select = (graphicController) ->
    bringToTop graphicController
    graphicController.view.dom.css 'box-shadow': '0px 0px 0px 3px blue'
  
  deselect = (graphicController) ->
    graphicController.view.dom.css 'box-shadow': ''
  
  slot.graphics.on 'activate', (_graphic) ->
    if _graphic is graphic
      select graphicController
  
  slot.graphics.on 'deactivate', (_graphic) ->
    if _graphic is graphic
      deselect graphicController
  
  # editor.ui.on 'deselect', (event) ->
  #   console.log 'deselect', event
  #   slot.graphics.deactivate()