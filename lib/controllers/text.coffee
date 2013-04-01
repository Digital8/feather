{EventEmitter} = require 'events'

uuid = require 'node-uuid'

TextView = require '../views/text'

module.exports = class Text extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @view = new TextView
      text: @text
      editor: @editor
      parent: @parent
      mode: @mode
  
  show: ->
    @view.show()
    @emit 'show'
  
  hide: ->
    @view.hide()
    @emit 'hide'