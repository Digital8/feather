FilterTool = require './filter_tool'

module.exports = class Saturate extends FilterTool
  
  map: (value) ->
    saturate: "#{parseFloat(value) + 100}%"