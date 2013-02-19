{EventEmitter} = require 'events'

module.exports = class Slot extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      @[key] = value
    
    SlotView = require './views/slot'
    
    @view = new SlotView slot: this