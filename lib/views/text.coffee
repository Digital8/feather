{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Text extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @dom = jQuery '<div>'
    @dom.css
      position: 'absolute'
      left: 0
      top: 0
      'font-size': @text.size
      color: '#BADA55'
      width: @parent.width() * @text.width
      height: @parent.height() * @text.height
      top: @parent.height() * @text.top
      left: @parent.width() * @text.left
      'text-align': 'center'
      'vertical-align': 'middle'
    
    @dom.appendTo @parent
    
    @span = jQuery '<span>'
    # @span.css 'line-height': 1
    @span.appendTo @dom
    
    @span.html @text.value
    
    @fit()
    
    @text.on 'resize', =>
      @fit()
    
    @text.on 'color', (color) =>
      @span.css color: color
    
    @text.on 'font', (font) =>
      @span.css 'font-family': font
    
    @text.on 'value', (value) =>
      @span.html value
      @fit()
    
    if @mode is 'write'
      @dom.draggable()
      
      @dom.resizable
        handles: 'all'
        aspectRatio: on
        resize: =>
          @fit()
        # containment: @parent
      @dom.find('.ui-resizable-handle').addClass 'ui-handle'
    
    @fit()
  
  fit: ->
    `
    jQuery.fn.textfill = function(maxFontSize) {
        maxFontSize = parseInt(maxFontSize, 10);
        return this.each(function(){
            var ourText = jQuery("span", this),
                parent = ourText.parent(),
                maxHeight = parent.height(),
                maxWidth = parent.width(),
                fontSize = parseInt(ourText.css("fontSize"), 10),
                multiplier = maxWidth/ourText.width(),
                newSize = (fontSize*(multiplier-0.1));
            ourText.css(
                "fontSize", 
                (maxFontSize > 0 && newSize > maxFontSize) ? 
                    maxFontSize : 
                    newSize
            );
        });
    };
    `
    
    @dom.textfill()
    
    # resizer = jQuery """<span class="hidden-resizer" style="visibility: hidden; font-size: 333px;"></span>"""
    # resizer.appendTo document.body
    
    # resizer.html text.value
    
    # # desired_width = 500
    # # size = null
    # # steps = 100
    
    # while resizer.width() < @parent.width()
    #   steps--
    #   return if steps <= 0
      
    #   console.log resizer.width(), desired_width
      
    #   size = parseInt(resizer.css("font-size"), 10)
    #   resizer.css("font-size", size + 1)
    #   console.log size
    
    # text.resize size
  
  # size: ->
  #   @dom.css 'font-size': @text.size
  
  show: ->
    
    @dom.show()
    
    @emit 'show'
  
  hide: ->
    
    @dom.hide()
    
    @emit 'hide'