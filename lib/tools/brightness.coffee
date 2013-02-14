FilterTool = require './filter_tool'

module.exports = class Brightness extends FilterTool
  
  map: (value) ->
    
    if value < 0
      value /= 100
      value *= 0.5
    else
      value /= 100
      value *= 0.75
    
    return brightness: "#{value}"