{EventEmitter} = require 'events'

module.exports = class Gate extends EventEmitter
  
  constructor: (args) ->
    
    # super
    
    return unless args?
    
    @[key] = value for key, value of args
    
    @default ?= ->
  
  augment: (instance) ->
    
    if property.default?
      instance[key] = property.default()
    
    return