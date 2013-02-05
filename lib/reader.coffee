{EventEmitter} = require 'events'

module.exports = class Reader extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      @[key] = value
  
  handle: (event) ->
    
    @reader = new FileReader
    
    @reader.addEventListener 'load', =>
      @emit 'read', @reader.result
    
    @reader.readAsDataURL event.target.files[0]