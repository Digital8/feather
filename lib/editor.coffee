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
    
    args.hook ?= (object, args...) ->
      console.log 'hook', @key, @to, "#{object.constructor.name} -> #{object[@to].constructor.name}", args...
    
    @proxies.new args
  
  @proxy 'cancel', to: 'repo', audit: on, hook: (object) => object.deactivate()
  
  @proxy 'commit', to: 'kit', audit: on
  @proxy 'activate', to: 'kit', audit: on
  @proxy 'deactivate', to: 'kit', audit: on # , hook: (object) => object.cancel()
  @proxy 'reset', to: 'kit', audit: on, hook: (object) => object.deactivate()
  
  @property 'id', default: uuid, audit: on
  
  @property 'repo', default: (-> new Repo), audit: on
  
  @property 'gates', default: (-> {}), audit: on
  
  constructor: (args = {}) ->
    for key, property of @constructor.properties.objects
      if property.default?
        @[property.key] = property.default()
    
    for key, proxy of @constructor.proxies.objects then do (key, proxy) =>
      
      @[proxy.key] = ->
        
        @[proxy.to][proxy.key] arguments...
        
        proxy.hook? this, arguments...
        
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
    
    @ui.stage.css width: @width
    @ui.stage.css height: @height
    
    @graphics = new Library type: Graphic
    @graphics.on 'add', (graphic) =>
      
      @emit 'graphic', graphic
    
    @on 'image', (image) =>
      
      @graphics.new dom: (jQuery image), editor: this
    
    @augmentations = new Library
    
    @on 'graphic', (graphic) =>
      
      @ui.stage.append graphic.dom
      
      setTimeout =>
        @setFilter()
      , 333
    
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
    
    @on 'setFilter', =>
      @pushFilters()
  
  sepia: ->
    @activate 'sepia'
  
  greyscale: ->
    @activate 'greyscale'
  
  sharpness: ->
    console.log 'sharpness'
    @activate 'sharpness'
  
  pushFilters: =>
    for key, graphic of @graphics.objects then do (key, graphic) =>
      graphic.pushFilters()
  
  image: (src) ->
    
    image = new Image
    
    image.onload = =>
      
      @emit 'image', image
    
    image.src = src
  
  setFilter: (map = {}) ->
    @filters ?=
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
      contrast: '100%'
      sepia: '0%'
      blur: '0px'
    
    for key, value of map
      @filters[key] = value
    
    @emit 'setFilter'