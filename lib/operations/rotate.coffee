Operation = require '../operation'

module.exports = class Rotate extends Operation
  
  operate: (args = {}) ->
    
    {graphic, theta} = args
    
    {image} = graphic
    
    cw = image.width
    ch = image.height
    
    cx = 0
    cy = 0
    
    switch theta
      when (Math.PI / 2)
        cw = image.height
        ch = image.width
        cy = image.height * -1
        break
      
      when Math.PI
        cx = image.width * -1
        cy = image.height * -1
        break
      
      when (Math.PI / 2) * 3
        cw = image.height
        ch = image.width
        cx = image.width * -1
        break
    
    canvas = document.createElement 'canvas'
    canvas.width = cw
    canvas.height = ch
    
    ctx = canvas.getContext '2d'
    
    ctx.rotate theta
    
    ctx.drawImage image, cx, cy
    
    url = canvas.toDataURL()
    
    return url: url, width: cw, height: ch