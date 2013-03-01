{EventEmitter} = require 'events'

Layout = require './layout'

module.exports = class Template extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      @[key] = value
  
  spawn: ->
    
    layout = @editor.layouts.new template: this, editor: @editor