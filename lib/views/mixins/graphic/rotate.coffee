module.exports = (graphicController) ->
  
  {graphic, editor, view, slotController} = graphicController
  
  graphic.filters ?=
    fliph: no
    flipv: no
  
  {slot} = graphic
  
  editor.ui.on 'orientate', (key) ->
    if key is 'horizontal'
      if graphic is graphic.slot.graphics.active
        graphic.filters.fliph = not graphic.filters.fliph
    
    if key is 'vertical'
      if graphic is graphic.slot.graphics.active
        graphic.filters.flipv = not graphic.filters.flipv
    
    slot.filters.emit 'change'
    
    graphic.emit 'orientate'
  
  graphic.on 'activate', ->
    if editor.kit.active?.key is 'orientation'
      editor.ui.rotate.enable()
  graphic.on 'deactivate', ->
    if editor.kit.active?.key is 'orientation'
      editor.ui.rotate.disable()
  
  editor.kit.on 'activate', ({key}) ->
    if key is 'orientation'
      if graphic.slot.graphics.active is graphic
        editor.ui.rotate.enable()
  editor.kit.on 'deactivate', ({key}) ->
    if key is 'orientation'
      if graphic.slot.graphics.active is graphic
        editor.ui.rotate.disable()