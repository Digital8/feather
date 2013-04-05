querystring = require 'querystring'

process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image, editor} = graphic
  
  graphic.filters ?= {}
  
  for key, value of graphic.filters
    filters[key] = value
  
  if window.CanvasRenderingContext2D? isnt editor.ENV.homo?
    
    {url} = process image: image, filters: filters, util: require './util'
    
    graphic.emit 'src', url
  
  else
    
    # f = {}
    # for k, v of filters
    #   f[k] = v or 0
    # debugger
    
    if window.location.hostname is 'localhost'
      
      json = JSON.stringify filters
      
      graphic.emit 'src', "http://localhost:8080/filter/#{encodeURIComponent graphic.image.src}?args=#{encodeURIComponent json}"
    
    else
      
      graphic.emit 'src', "http://api.takesitlikeapro.com:8080/filter/#{encodeURIComponent graphic.image.src}?args=#{querystring.stringify f}"