querystring = require 'querystring'

process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image, editor} = graphic
  
  graphic.filters ?= {}
  
  for key, value of graphic.filters
    filters[key] = value
  
  if window.CanvasRenderingContext2D? and not editor.ENV.homo?
    {width, height} = image
    quality = 200000 / (width * height)
    if quality > 1 then quality = 1
    
    {url} = process image: image, filters: filters, util: require './util', config: {quality: quality}
    
    graphic.emit 'src', url
  
  else
    
    json = JSON.stringify filters
    
    if window.location.hostname is 'localhost'
      
      graphic.emit 'src', "http://localhost:8080/filter/#{encodeURIComponent graphic.image.src}?args=#{encodeURIComponent json}"
    
    else
      
      graphic.emit 'src', "http://api.takesitlikeapro.com:8080/filter/#{encodeURIComponent graphic.image.src}?args=#{encodeURIComponent json}"