{EventEmitter} = require 'events'

module.exports = class Property extends EventEmitter
  
  constructor: (args) ->
    
    # super
    
    return unless args?
    
    for key, value of args
      @[key] = value
    
    @default ?= ->
  
  augment: (instance) ->
    
    if property.default?
      instance[key] = property.default()
    
    return