{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Editor extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @dom = args.dom
    
    @width = (jQuery '#tools').width()
    @height = (jQuery '#tools').height()
    
    debugger
    
    @images = {}
    
    handle = jQuery """
      <div id="handle" class="ui-resizable-handle" style="display: none; width: 100%; height: 22px; background: red;"></div>
    """
    handle.appendTo document.body
    
    @on 'image', (image) =>
      
      image.id ?= uuid()
      
      @images[image.id] = image
      
      @dom.append image
      
      $image = jQuery image
      $image.css
        width: @width
        height: @height
      $image.resizable(
        handles: 'all'
        minWidth: 100
        minHeight: 100
      ).parent('.ui-wrapper').draggable()
      
      (jQuery '.ui-wrapper').css overflow: 'visible'
  
  spawnImage: (url) ->
    
    image = new Image
    
    image.onload = =>
      
      @emit 'image', image
    
    image.src = url