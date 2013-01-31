{EventEmitter} = require 'events'

module.exports = class Queue extends EventEmitter
  
  constructor: (args = {}) ->
    super
    
    @array = []
  
  enque: (object) ->
    
    @array.push object
    
    @emit 'enque', object
  
  head: ->
    return unless @array?.length => 1
    
    return @array[0]
  
  length: -> @array.length