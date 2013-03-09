Base = require './core/base'

module.exports = class Editor extends Base
  
  constructor: (args = {}) ->
    
    super
    
    @setMaxListeners 0
    
    @modules = {}
    
    for key, _module of (require './modules')
      
      context =
        journal: []
        log: -> @journal.push arguments
      
      __module =
        key: key
        context: context
        result: _module this, args, context
      
      @modules[key] = __module
      
      @emit 'module', __module