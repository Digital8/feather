Tool = require '../tool'

module.exports = class FilterTool extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @editor.on 'ui', (key) =>
      
      if key is 'slider'
        
        [key, tool, value] = arguments
        
        return unless @key is tool
        
        map = @map value
        
        console.log tool, map
        
        # @editor.setFilter tool, (@map value)
        
        @editor.setFilters map