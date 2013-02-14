FilterTool = require './filter_tool'

module.exports = class Saturate extends FilterTool
  
  map: (value) ->
    saturate: "#{value + 100}%"