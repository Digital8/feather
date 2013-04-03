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
    
    if @mode is 'write'
      (require '../views/mixins/graphic/select') this
      (require '../views/mixins/graphic/translate') this
      (require '../views/mixins/graphic/scale') this
      (require '../views/mixins/graphic/rotate') this
      (require '../views/mixins/graphic/delete') this
      (require '../views/mixins/graphic/zoom') this
      (require '../views/mixins/graphic/crop') this
      (require '../views/mixins/graphic/quality') this
    
    @view.on 'mousedown', =>
      @emit 'interact'
  
  show: ->
    @view.show()
    @emit 'show'
  
  hide: ->
    @view.hide()
    @emit 'hide'