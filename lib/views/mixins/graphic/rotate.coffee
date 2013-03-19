module.exports = (graphicController) ->
  
  {graphic, editor, view, slotController} = graphicController
  
  graphic.filters ?=
    fliph: no
    flipv: no
    rotate: 0
  
  {slot} = graphic
  
  editor.ui.on 'orientate', (key) ->
    
    return unless graphic is graphic.slot.graphics.active
    
    if key is 'horizontal'
      graphic.filters.fliph = not graphic.filters.fliph
    
    if key is 'vertical'
      graphic.filters.flipv = not graphic.filters.flipv
    
    if key is 'clockwise'
      graphic.filters.rotate += Math.PI / 2
    
    if key is 'anticlockwise'
      graphic.filters.rotate -= Math.PI / 2
    
    while graphic.filters.rotate > (Math.PI * 2)
      graphic.filters.rotate -= (Math.PI * 2)
    
    while graphic.filters.rotate < 0
      graphic.filters.rotate += (Math.PI * 2)
    
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