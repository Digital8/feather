# Base = require './base'

{EventEmitter} = require 'events'

module.exports = class Property extends EventEmitter
  
  constructor: (args = {}) ->
    
    # super
    
    for key, value of args
      console.log 'key', value
      @[key] = value