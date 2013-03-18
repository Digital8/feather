{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Graphic extends EventEmitter
  
  debug: ->
    @debugDom = jQuery '<div>'
    @debugDom.css
      position: 'absolute'
      top: 0
      left: 0
      height: '10%'
      width: '100%'
      'font-size': 10
      color: 'white'
    @debugDom.appendTo @dom
    
    setInterval =>
      @debugDom.text """
        @slot.aspect: #{@graphic.aspect.toFixed(2)}
        @aspect #{(@dom.width() / @dom.height()).toFixed(2)}
      """
    , 1000
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @dom = jQuery '<div>'
    @dom.css
      position: 'absolute'
      left: 0
      top: 0
    @dom.appendTo @parent
    
    @image = jQuery '<img>'
    @image.appendTo @dom
    @image.css
      position: 'absolute'
      width: '100%'
      height: '100%'
      left: 0
      top: 0
    @image.attr src: @graphic.image.src
    
    # @graphic.on 'resize', =>
    # @contain()
    
    @contain()
    
    @graphic.on 'resize', =>
      @size()
    
    @size()
    
    @graphic.on 'move', =>
      @position()
    
    @position()
    
    # @debug()
    
    @graphic.on 'src', (src) =>
      @image.attr src: src
    
    @dom.on 'click', (event) =>
      @emit 'click'
      return
    
    @dom.on 'mousedown', (event) =>
      @emit 'mousedown'
      return
  
  position: ->
    @dom.css
      left: @graphic.offset.left * @parent.width()
      top: @graphic.offset.top * @parent.height()
  
  size: ->
    
    @dom.css
      width: @graphic.relative.width * @parent.width()
      height: @graphic.relative.height * @parent.height()
  
  contain: ->
    @dom.css
      width: @graphic.image.width
      height: @graphic.image.height
  
  show: ->
    
    @dom.show()
    
    @emit 'show'
  
  hide: ->
    
    @dom.hide()
    
    @emit 'hide'