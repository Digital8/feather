process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image} = graphic
  
  graphic.filters ?= {}
  
  for key, value of graphic.filters
    filters[key] = value
  
  src = process image: image, filters: filters
  
  graphic.emit 'src', src