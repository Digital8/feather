FilterTool = require './filter_tool'

module.exports = class Temperature extends FilterTool
  
  map: (value) ->
    return {
      'hue-rotate': "#{-1 * value / 2}deg"
    }