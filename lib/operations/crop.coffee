Operation = require '../operation'

module.exports = class Crop extends Operation
  
  operate: (args = {}) ->
    
    {image, top, left, width, height} = args
    
    canvas = document.createElement 'canvas'
    canvas.width = width
    canvas.height = height
    
    ctx = canvas.getContext '2d'
    
    ctx.drawImage image, -left, -top
    
    url = canvas.toDataURL()
    
    return url