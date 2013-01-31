{EventEmitter} = require 'events'

uuid = require 'node-uuid'
async = require 'async'

if jQuery.fx.speeds?
  jQuery.fx.speeds.swift = 75

Library = require './library'
Graphic = require './graphic'
Kit = require './kit'
Repo = require './repo'

Base = require './base'

Property = require './property'

Mixins = require './mixins'

Tools = require './tools'

module.exports = class Editor extends EventEmitter
  
  @properties = new Library type: Property, key: 'key'
  @proxies = new Library type: Property, key: 'key'
  
  @property = (key, args = {}) ->
    args.key ?= key
    args.default ?= ->
    
    @properties.new args
  
  @proxy = (key, args = {}) =>
    args.key ?= key
    
    args.hook ?= (object) ->
      console.log 'hook', @key, @to, "#{object.constructor.name} -> #{object[@to].constructor.name}"
    
    @proxies.new args
  
  @proxy 'commit', to: 'repo', audit: on
  @proxy 'cancel', to: 'repo', audit: on, hook: (object) => object.deactivate()
  
  @proxy 'activate', to: 'kit', audit: on
  @proxy 'deactivate', to: 'kit', audit: on
  @proxy 'reset', to: 'kit', audit: on
  
  @property 'id', default: uuid, audit: on
  
  @property 'repo', default: (-> new Repo), audit: on
  
  @property 'gates', default: (-> {}), audit: on
  
  constructor: (args = {}) ->
    for key, property of @constructor.properties.objects
      if property.default?
        @[property.key] = property.default()
    
    for key, proxy of @constructor.proxies.objects then do (key, proxy) =>
      
      @[proxy.key] = ->
        
        proxy.hook? this
        
        @[proxy.to][proxy.key] arguments...
        
        if proxy.audit
          
          @emit 'audit', proxy.key, arguments...
    
    super
    
    @on 'audit', (key, args...) =>
      console.log 'auditing', key, args...
      
      @emit key, args...
    
    @ui = {}
    @ui.stage = jQuery '#stage'
    
    args.ui ?= {}
    
    for key, selector of args.ui then do (key, selector) =>
      element = jQuery selector
      do (element) =>
        element.click (event) =>
          event.preventDefault()
          
          @emit 'ui', key
    
    @on 'ui', (key) ->
      console.log 'ui', key
      
      @[key]()
    
    @width = @ui.stage.width()
    @height = @ui.stage.height()
    
    @graphics = new Library type: Graphic
    @graphics.on 'add', (graphic) =>
      
      @emit 'graphic', graphic
    
    @on 'image', (image) =>
      
      @graphics.new dom: jQuery image
    
    @augmentations = new Library
    
    @on 'graphic', (graphic) =>
      
      @ui.stage.append graphic.dom
    
    mixins =
      select: Mixins.select
      scale: Mixins.scale
      move: Mixins.move
      delete: Mixins.delete
      crop: Mixins.crop
    
    for key, mixin of mixins
      @augmentations.add (mixin.augment this) or {}
    
    @kit = new Kit editor: this
    for key, tool of Tools
      @kit.include tool
    
    # @kit.on 'activate', (tool) =>
    #   @emit 'tool', tool
    
    # @on 'tool:request', (key, ui) =>
      
    #   @activateTool arguments...
    
    # @effects = new Library type: Effect
  
  image: (src) ->
    
    image = new Image
    
    image.onload = =>
      
      @emit 'image', image
    
    image.src = src
  
  # toJSON: ->
  #   return {
  #     images: @images.toJSON()
  #     kit: @kit.toJSON()
  #     journal: @journal.toJSON()
  #   }
  
  # commit: (callback = ->) ->
  #   return unless @kit.active?
    
  #   @journal.commit entry
  
  # cancel: (callback = ->) ->
  #   @kit.cancel callback
  
  # activateTool: (key) ->
  #   return unless @gates.activateTool? key
    
  #   @kit.activate key