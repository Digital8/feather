Operation = require '../operation'

module.exports = class Scale extends Operation
  
  operate: (args = {}) ->
    
    {image, width, height} = args
    
    canvas = document.createElement 'canvas'
    canvas.width = width
    canvas.height = height
    
    ctx = canvas.getContext '2d'
    
    ctx.drawImage image, 0, 0, width, height
    
    url = canvas.toDataURL()
    
    return url