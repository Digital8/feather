FilterTool = require './filter_tool'

module.exports = class Blur extends FilterTool
  
  map: (value) ->
    
    value /= 50
    value *= -1
    value *= 5
    value = Math.max 0, value
    
    return blur: "#{value}px"