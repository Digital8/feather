module.exports = (graphicController) ->
  
  {graphic, editor} = graphicController
  
  {slot} = graphic
  
  zIndex = 666
  
  bringToTop = (graphicController) ->
    zIndex++
    graphicController.view.dom.css 'z-index': zIndex
  
  graphicController.on 'interact', ->
    
    graphic.slot.graphics.activate graphic
  
  select = (graphicController) ->
    bringToTop graphicController
    graphicController.view.dom.css 'box-shadow': '0px 0px 0px 3px #8ac53f'
  
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