Operation = require '../operation'

module.exports = class Mirror extends Operation
  
  operate: (args = {}) ->
    
    {graphic, width, height} = args
    
    {scale, clone, image} = graphic
    
    canvas = document.createElement 'canvas'
    canvas.width = 100 # clone.width
    canvas.height = 100 # clone.height
    
    ctx = canvas.getContext '2d'
    
    # ctx.scale 1, -1
    # ctx.translate 0, clone.height
    
    ctx.drawImage clone, 100, 100 # clone.width, clone.height
    
    url = canvas.toDataURL()
    
    return url: url