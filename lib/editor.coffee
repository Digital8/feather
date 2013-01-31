{EventEmitter} = require 'events'

uuid = require 'node-uuid'

if jQuery.fx.speeds?
  jQuery.fx.speeds.swift = 75

Library = require './library'
Graphic = require './graphic'
Kit = require './kit'
# Tool = require './tool'

mixins =
  move: require './mixins/move'
  scale: require './mixins/scale'
  select: require './mixins/select'

module.exports = class Editor extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @id = args.id or uuid()
    
    @dom = args.dom
    
    @ui = {}
    # @ui.tools = jQuery '#tools'
    @ui.stage = jQuery '#stage'
    
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
    
    # for key, mixin of mixins
    for mixin in [mixins.select, mixins.scale, mixins.move]
      augmentation = mixin.augment this
      augmentation ?= {}
      @augmentations.add augmentation
    
    @kit = new Kit editor: this
    @kit.addTool require './tools/scale'
    
    @kit.on 'activate', (tool) =>
      @emit 'tool', tool
    
    @on 'tool:request', (key, ui) =>
      
      @activateTool arguments...
    
    @on 'cancel:request', =>
      
      @activateTool null
    
    @on 'apply:request', =>
      
      @activateTool null
  
  activateTool: (key) ->
    console.log arguments...
    
    @kit.activate key
    
    # @emit 'tool', arguments...
  
  spawnImage: (url) ->
    
    image = new Image
    
    image.onload = =>
      
      @emit 'image', image
    
    image.src = url