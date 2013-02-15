Tool = require '../tool'

module.exports = class FilterTool extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @editor.on 'ui', (key) =>
      
      if key is 'slider'
        
        [key, tool, value] = arguments
        
        return unless @key is tool
        
        @editor.setFilters (@map value)