# Library = require './library'

{EventEmitter} = require 'events'

uuid = require 'node-uuid'

# Gate = require './gate'
# Property = require './property'
# Proxy = require './proxy'

module.exports = class Base extends EventEmitter
  
  # # @library = (key) -> @[key] = new Library type: Object, key: 'key'
  
  # @has (type, args = {}) = ->
  
  #   key = args.as
    
  #   # library = @library type: type
  #   # @[key] = library
    
  #   @[type.name.toLowerCase] = ->
    
  #   # return library
  
  # @has Gate, as: 'gates'
  # @has Property, as: 'properties'
  # @has Proxy, as: 'proxies'
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()