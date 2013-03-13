{EventEmitter} = require 'events'

uuid = require 'node-uuid'

GraphicView = require '../views/graphic'

module.exports = class Graphic extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @view = new GraphicView
      graphic: @graphic
      editor: @editor
      parent: @parent
  
  show: ->
    @view.show()
    @emit 'show'
  
  hide: ->
    @view.hide()
    @emit 'hide'