util = require './util'

processors = require './processors'

module.exports = ({image, filters}) ->
  
  {width, height} = image
  
  canvas = util.scaleImageToCanvas image, 0.5
  ctx = canvas.getContext '2d'
  
  {image, width} = canvas
  
  inData = ctx.getImageData 0, 0, width, height
  outData = util.createImageData ctx, width, height
  
  [inData, outData] = [outData, inData]
  
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
  
  ctx.putImageData outData, 0, 0
  
  return canvas.toDataURL()