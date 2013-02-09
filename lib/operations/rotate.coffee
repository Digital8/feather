Operation = require '../operation'

module.exports = class Rotate extends Operation
  
  constructor: (args = {}) ->
    
    super
    
    @id = 'rotate'
  
  operate: (args = {}) ->
    
    {graphic} = args
    
    {theta, clone} = graphic
    
    cw = clone.width
    ch = clone.height
    
    cx = 0
    cy = 0
    
    switch theta
      when (Math.PI / 2)
        cw = clone.height
        ch = clone.width
        cy = clone.height * -1
        break
      
      when Math.PI
        cx = clone.width * -1
        cy = clone.height * -1
        break
      
      when (Math.PI / 2) * 3
        cw = clone.height
        ch = clone.width
        cx = clone.width * -1
        break
    
    canvas = document.createElement 'canvas'
    canvas.width = cw
    canvas.height = ch
    
    ctx = canvas.getContext '2d'
    
    ctx.rotate theta
    
    ctx.drawImage clone, cx, cy
    
    url = canvas.toDataURL()
    
    return url: url, width: cw, height: ch