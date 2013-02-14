{EventEmitter} = require 'events'

module.exports = class Module extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @key = args.key or 'master'