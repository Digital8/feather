Tool = require '../tool'

module.exports = class FilterTool extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @editor.on 'ui', (key) =>
      
      if key is 'slider'
        
        [key, tool, value] = arguments
        
        if tool is @key
        
          @editor.setFilter tool, value