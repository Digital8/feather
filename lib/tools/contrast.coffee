FilterTool = require './filter_tool'

module.exports = class Contrast extends FilterTool
  
  map: (value) ->
    
    if value < 0
      value *= -0.75
      value = 100 - value
    else
      value *= 3.33
    
    return contrast: "#{value}%"