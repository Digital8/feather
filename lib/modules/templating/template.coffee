{EventEmitter} = require 'events'

Library = require './library'
Slot = require './slot'

module.exports = class Template extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      @[key] = value
    
    @slots = new Library type: Slot
    
    @slots.on 'add', (slot) =>
      console.log 'slot', slot
    
    for datum in @data
      # console.log datum
      @slots.new datum