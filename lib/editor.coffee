Base = require './core/base'

module.exports = class Editor extends Base
  
  constructor: (args = {}) ->
    
    super
    
    @modules = {}
    
    for key, _module of (require './modules')
      
      module = _module this, args
      
      @modules[key] = module