# module.exports = (editor) ->
  
#   rotate = (direction, theta) =>
#     graphic = editor.selected
    
#     return unless graphic?
    
#     graphic.theta += theta
    
#     while graphic.theta > (Math.PI * 2)
#       graphic.theta -= (Math.PI * 2)
    
#     while graphic.theta < 0
#       graphic.theta += (Math.PI * 2)
    
#     _commit 'rotate', theta
    
#     return
  
#   (jQuery '#orientation-clockwise').click (event) =>
#     event.preventDefault()
#     rotate 'clockwise', Math.PI / 2
  
#   (jQuery '#orientation-anticlockwise').click (event) =>
#     event.preventDefault()
#     rotate 'anticlockwise', (Math.PI / 2) * 3
  
#   mirror = (dimension) =>
#     graphic = editor.selected
    
#     return unless graphic?
    
#     graphic.scale[dimension] *= -1
    
#     _commit 'mirror', dimension
    
#     return
  
#   (jQuery '#orientation-vertical').click (event) =>
#     event.preventDefault()
#     mirror 1
  
#   (jQuery '#orientation-horizontal').click (event) =>
#     event.preventDefault()
#     mirror 0
  
#   (jQuery '#tool-orientation').find('a').css opacity: 0.5
  
#   editor.on 'graphic', (graphic) =>
    
#     graphic.theta ?= 0
#     graphic.scale ?= [1, 1]
    
#     graphic.on 'select', ->
#       (jQuery '#tool-orientation').find('a').css opacity: 1
    
#     graphic.on 'deselect', ->
#       (jQuery '#tool-orientation').find('a').css opacity: 0.5
  
#   _commit = (op, args...) ->
#     if op is 'mirror'
#       [dimension] = args
      
#       graphic = editor.selected
      
#       {src} = editor.operations.mirror.operate graphic: graphic, dimension: dimension
      
#       graphic.image.src = src
    
#     if op is 'rotate'
#       [theta] = args
      
#       graphic = editor.selected
      
#       save = graphic.save()
      
#       {url, width, height} = editor.operations.rotate.operate graphic: graphic, theta: theta
      
#       previous = [save.css.left + (save.css.width / 2), save.css.top + (save.css.height / 2)]
      
#       graphic.image.src = url
      
#       graphic.dom.css
#         left: previous[0] - (save.css.height / 2)
#         top: previous[1] - (save.css.width / 2)
#         width: save.css.height
#         height: save.css.width