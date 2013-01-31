{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Graphic extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @id = args.id or uuid()
    
    @dom = jQuery """<div>"""
    @dom.css
      position: 'absolute'
      left: 0
      right: 0
      width: '100%'
      height: '100%'
    
    @element = args.dom
    @element.appendTo @dom
    
    @element.css
      width: '100%'
      height: '100%'
    
    # do @fit
  
  # fit: (stage) ->
  #   @dom.css
  #     width: stage.width()
  #     height: stage.height()
  #     position: 'absolute'
  #     top: 0
  #     left: 0
  
  build: ->
    
    # (jQuery '#stage').find('.ui-resizable-handle').fadeOut 'swift'
    
    # @dom.parent('.ui-wrapper').find('.ui-resizable-handle').fadeOut 'swift'
    
    # @dom.parent('.ui-wrapper').mousedown (event) =>
    #   event.stopPropagation()
    #   (jQuery '#stage').find('.ui-resizable-handle').fadeOut 'swift'
    #   console.log 'fading in image handles'
    #   @dom.parent('.ui-wrapper').find('.ui-resizable-handle').fadeIn 'swift'
    #   @zIndex++
    #   @dom.parent('.ui-wrapper').css zIndex: @zIndex