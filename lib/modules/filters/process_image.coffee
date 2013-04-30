# util = require './util'

processors = require './processors'

module.exports = ({image, filters, util, config}) ->
  
  {width, height} = image
  
  canvas = util.scaleImageToCanvas image, (config?.quality or 1)
  ctx = canvas.getContext '2d'
  
  {width, height} = canvas
  
  inData = ctx.getImageData 0, 0, width, height
  outData = util.createImageData ctx, width, height
  
  [inData, outData] = [outData, inData]
  
  if filters.crop?
    
    [inData, outData] = [outData, inData]
    
    {crop} = filters
    
    crop =
      left: parseInt (crop.left * width)
      top: parseInt (crop.top * height)
      width: parseInt (crop.width * width)
      height: parseInt (crop.height * height)
    
    canvas2 = util.canvas crop.width, crop.height
    
    ctx2 = canvas2.getContext '2d'
    
    ctx.putImageData inData, 0, 0
    ctx2.drawImage canvas, -crop.left, -crop.top
    
    width = crop.width
    height = crop.height
    inData = util.createImageData ctx2, width, height
    outData = ctx2.getImageData 0, 0, width, height
  
  # flipv
  if filters.flipv
    [inData, outData] = [outData, inData]
    processors.fliph inData.data, outData.data, width, height
  
  # fliph
  if filters.fliph
    [inData, outData] = [outData, inData]
    processors.flipv inData.data, outData.data, width, height
  
  if filters.saturation isnt 0
    [inData, outData] = [outData, inData]
    processors.hsl inData.data, outData.data, width, height,
      hue: 0
      saturation: filters.saturation / 100
      lightness: 0
  
  if filters.lightness isnt 0
    [inData, outData] = [outData, inData]
    processors.hsl inData.data, outData.data, width, height,
      hue: 0
      saturation: 0
      lightness: filters.lightness / 100
  
  if 0 < filters.focus < 100
    [inData, outData] = [outData, inData]
    processors.sharpen3x3 inData.data, outData.data, width, height,
      strength: filters.focus / 100
  
  if -100 < filters.focus < 0
    [inData, outData] = [outData, inData]
    processors.blur inData.data, outData.data, width, height,
      kernelSize: Math.floor (-filters.focus / 10)
  
  if -100 < filters.temperature < 0
    [inData, outData] = [outData, inData]
    processors.colorfilter inData.data, outData.data, width, height,
      r: filters.temperature / 200
      g: -filters.temperature / 200
      b: -filters.temperature / 100
  
  if 0 < filters.temperature < 100
    [inData, outData] = [outData, inData]
    processors.colorfilter inData.data, outData.data, width, height,
      r: filters.temperature / 100
      g: -filters.temperature / 200
      b: -filters.temperature / 100
  
  if filters.contrast isnt 0
    [inData, outData] = [outData, inData]
    processors.brightness inData.data, outData.data, width, height,
      contrast: filters.contrast / 100
  
  if filters.sepia isnt 0
    [inData, outData] = [outData, inData]
    processors.sepia inData.data, outData.data, width, height
  
  if filters.rotate isnt 0
    
    [inData, outData] = [outData, inData]
    
    theta = filters.rotate
    
    ctx.putImageData inData, 0, 0
    
    cw = width
    ch = height
    
    cx = 0
    cy = 0
    
    switch theta
      when (Math.PI / 2)
        cw = height
        ch = width
        cy = height * -1
        break
      
      when Math.PI
        cx = width * -1
        cy = height * -1
        break
      
      when (Math.PI / 2) * 3
        cw = height
        ch = width
        cx = width * -1
        break
    
    canvas2 = util.canvas cw, ch
    
    ctx2 = canvas2.getContext '2d'
    
    ctx2.rotate theta
    
    ctx2.drawImage canvas, cx, cy
    
    width = cw
    height = ch
    inData = util.createImageData ctx2, cw, ch
    outData = ctx2.getImageData 0, 0, cw, ch
  
  canvas.width = width
  canvas.height = height
  ctx.putImageData outData, 0, 0
  
  return canvas: canvas, url: canvas.toDataURL()