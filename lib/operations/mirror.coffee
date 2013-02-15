Operation = require '../operation'

module.exports = class Mirror extends Operation
  
  operate: (args = {}) ->
    
    {graphic, dimension} = args
    
    {image} = graphic
    
    canvas = document.createElement 'canvas'
    canvas.width = image.width
    canvas.height = image.height
    
    ctx = canvas.getContext '2d'
    
    if dimension is 0
      ctx.scale -1, 1
      ctx.translate -image.width, 0
    if dimension is 1
      ctx.scale 1, -1
      ctx.translate 0, -image.height
    
    ctx.drawImage image, 0, 0
    
    return src: canvas.toDataURL()