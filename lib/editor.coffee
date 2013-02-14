Base = require './core/base'

module.exports = class Editor extends Base
  
  constructor: (args = {}) ->
    
    super
    
    @modules = {}
    
    for key, _module of (require './modules')
      
      module = _module this, args
      
      @modules[key] = module
    
    # for key, property of @constructor.properties.objects
    #   property.augment this
    
    # for key, proxy of @constructor.proxies.objects then do (key, proxy) =>
    #   proxy.augment this
    
    # super
    
    # @on 'proxy', (key, args...) =>
    #   console.log 'auditing', key, args...
    #   @emit key, args...