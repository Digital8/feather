{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Editor extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @dom = args.dom
    
    @width = (jQuery '#tools').width()
    @height = (jQuery '#tools').height()
    
    @images = {}
    
    handle = jQuery """
      <div id="handle" class="ui-resizable-handle" style="display: none; width: 100%; height: 22px; background: red;"></div>
    """
    handle.appendTo document.body
    
    @zIndex = 100
    
    @on 'image', (image) =>
      
      image.id ?= uuid()
      
      @images[image.id] = image
      
      @dom.append image
      
      $image = jQuery image
      $image.css
        width: @width
        height: @height
        position: 'absolute'
        top: 0
        left: 0
      $image.resizable(
        handles: 'all'
        minWidth: 100
        minHeight: 100
      ).parent('.ui-wrapper').draggable()
      
      $image.parent('.ui-wrapper').css zIndex: @zIndex
      
      (jQuery '#stage').find('.ui-resizable-handle').fadeOut 'fast'
      
      $image.parent('.ui-wrapper').css overflow: 'visible'
      
      $image.parent('.ui-wrapper').find('.ui-resizable-handle').fadeOut 'fast'
      
      $image.parent('.ui-wrapper').mousedown (event) =>
        event.stopPropagation()
        (jQuery '#stage').find('.ui-resizable-handle').fadeOut 'fast'
        console.log 'fading in image handles'
        $image.parent('.ui-wrapper').find('.ui-resizable-handle').fadeIn 'fast'
        @zIndex++
        $image.parent('.ui-wrapper').css zIndex: @zIndex
      
      # (jQuery '#stage').selectable()
    
    (jQuery '#stage').mousedown ->
      console.log 'fading out all handles'
      (jQuery '#stage').find('.ui-resizable-handle').fadeOut 'fast'
  
  activateTool: (key) ->
    console.log arguments...
    
    @emit 'tool', arguments...
  
  spawnImage: (url) ->
    
    image = new Image
    
    image.onload = =>
      
      @emit 'image', image
    
    image.src = url