process = require './process_image'

module.exports = ({graphic, filters}) ->
  
  {image} = graphic
  
  src = process image: image, filters: filters
  
  graphic.emit 'src', src