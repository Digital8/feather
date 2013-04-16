querystring = require 'querystring'

process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image, editor} = graphic
  
  graphic.filters ?= {}
  
  for key, value of graphic.filters
    filters[key] = value
  
  if window.CanvasRenderingContext2D? and not editor.ENV.homo?
    {width, height} = image
    
    quality = 1000000 / (width * height)
    if quality > 1 then quality = 1
    
    {url} = process image: image, filters: filters, util: (require './util'), config: {quality: quality}
    
    graphic.emit 'src', url
  
  else
    
    {api} = editor
    
    json = JSON.stringify filters
    
    graphic.emit 'src', "#{api}/filter/#{encodeURIComponent graphic.image.src}?args=#{encodeURIComponent json}"