querystring = require 'querystring'

process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image, editor} = graphic
  
  graphic.filters ?= {}
  
  for key, value of graphic.filters
    filters[key] = value
  
  if window.CanvasRenderingContext2D? and not editor.ENV.homo?
    
    {url} = process image: image, filters: filters, util: require './util'
    
    graphic.emit 'src', url
  
  else
    
    json = JSON.stringify filters
    
    if window.location.hostname is 'localhost'
      
      graphic.emit 'src', "http://localhost:8080/filter/#{encodeURIComponent graphic.image.src}?args=#{encodeURIComponent json}"
    
    else
      
      graphic.emit 'src', "http://api.takesitlikeapro.com:8080/filter/#{encodeURIComponent graphic.image.src}?args=#{encodeURIComponent json}"