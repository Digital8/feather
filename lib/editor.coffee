{EventEmitter} = require 'events'

uuid = require 'node-uuid'
async = require 'async'

jQuery?.fx?.speeds?.swift = 75

Property = require './property'

Library = require './library'
Graphic = require './graphic'
Kit = require './kit'
Repo = require './repo'
Reader = require './reader'
Template = require './template'
Slot = require './slot'
Surface = require './surface'
Layout = require './layout'

Mixins = require './mixins'
Tools = require './tools'
Operations = require './operations'
Templates = require './templates'

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
  @proxy 'deactivate', to: 'kit', audit: on
  @proxy 'reset', to: 'kit', audit: on, hook: (object) => object.deactivate()
  
  @property 'id', default: uuid, audit: on
  @property 'repo', default: (-> new Repo), audit: on
  
  constructor: (args = {}) ->
    for key, property of @constructor.properties.objects
      if property.default?
        @[property.key] = property.default()
    
    for key, proxy of @constructor.proxies.objects then do (key, proxy) =>
      
      @[proxy.key] = ->
        
        gates = (@gates.get proxy.key)
        if gates?
          for key, gate of gates.objects
            return unless gate.call this
        
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
    
    @on 'ui', (key) =>
      console.log 'ui', key
      
      @[key]()
    
    @width = @ui.stage.width()
    @height = @ui.stage.height()
    
    @ui.stage.css width: @width
    @ui.stage.css height: @height
    
    @stage =
      width: (jQuery '#tools').width()
      height: (jQuery '#tools').height()
    @stage.aspect = @stage.width / @stage.height
    
    @graphics = new Library type: Graphic
    @graphics.on 'add', (graphic) =>
      
      @emit 'graphic', graphic
    
    @on 'image', (image) =>
      
      stage =
        width: @surface.data.width
        height: @surface.data.height
      
      stage.aspect = stage.width / stage.height
      
      image.aspect = image.width / image.height
      
      if image.aspect < stage.aspect
        scale = stage.width / image.width
      else if image.aspect >= stage.aspect
        scale = stage.height / image.height
      
      image.width *= scale
      image.height *= scale
      
      graphic = @graphics.new image: image, editor: this
      
      if image.height > stage.height
        
        graphic.dom.css
          top: -((image.height - stage.height) / 2)
      
      if image.width > stage.width
        graphic.dom.css
          left: -((image.width - stage.width) / 2)
    
    @augmentations = new Library key: 'key'
    
    @on 'graphic', (graphic) =>
      
      @surface.element.append graphic.dom
      
      setTimeout =>
        @setFilter()
        Feather.quality()
        graphic.bringToTop()
        @augmentations.get('select').deselect()
      , 333
    
    mixins =
      select: Mixins.select
      scale: Mixins.scale
      move: Mixins.move
      delete: Mixins.delete
    
    for key, mixin of mixins
      @augmentations.add (mixin.augment this) or {}
    
    @kit = new Kit editor: this
    for key, tool of Tools
      @kit.include tool
    
    @on 'setFilter', =>
      @pushFilters()
    
    @operations = new Library
    @operations.add new Operations.crop
    
    @surface = new Surface editor: this
    
    # reader ###
    @reader = new Reader
    @reader.on 'read', (dataURL) =>
      @image dataURL
    
    ### templates ###
    @templates = new Library type: Template, key: 'key'
    
    @templates.on 'add', (template) =>
      $a = jQuery """<a>#{template.key}</a>"""
      $a.appendTo document.body
      $a.click =>
        @layouts.new template: template
    
    for key, data of Templates
      data.key = key
      @templates.new data
    
    @layouts = new Library type: Layout
    @layouts.on 'add', (layout) =>
      layout.dom.appendTo @surface.element
    
    ### gates ###
    @gates = new Library type: Library, key: 'key'
    for key, gate of args.gates
      library = @gates.new key: key
      library.add gate
    
    @augmentations.get('select').on 'select', (graphic) =>
      
      # clone = graphic.dom.clone()
      # clone.hide()
      # clone.appendTo graphic.dom.parent()
      # clone.css 'z-index': 10000
      # clone.fadeIn =>
      #   clone.hide()
      #   graphic.bringToTop()
      
      graphic.bringToTop()
  
  soft: ->
    @activate 'soft'
  
  singe: ->
    @activate 'singe'
  
  sepia: ->
    @activate 'sepia'
  
  greyscale: ->
    @activate 'greyscale'
  
  sharpness: ->
    @activate 'sharpness'
  
  pushFilters: =>
    for key, graphic of @graphics.objects then do (key, graphic) =>
      graphic.pushFilters()
  
  image: (src) ->
    
    image = new Image
    
    image.onload = =>
      
      return if image._loaded
      
      image._loaded = true
      
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