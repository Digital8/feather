process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image} = graphic
  
  graphic.filters ?= {}
  
  for key, value of graphic.filters
    filters[key] = value
  
  {url} = process image: image, filters: filters
  
  graphic.emit 'src', url