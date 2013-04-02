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
      'z-index': 1000
    
    @dom.appendTo @parent
    
    @span = jQuery '<span>'
    @span.css 'line-height': 1
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
      @dom.draggable
        drag: =>
          @emit 'interact'
      
      @deletable()
      @selectable()
      @scalable()
    
    @fit()
    
    @text.on 'activate', =>
      @editor.ui.emit 'text', @text
  
  scalable: ->
    
    {editor, text} = this
    
    {slot} = text
    
    scalable = =>
      
      resizable = @dom.resizable
        handles: 'all'
        aspectRatio: on
        resize: =>
          @fit()
      
      @dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
      return {
        resizable: resizable
        destroy: ->
          resizable.resizable 'destroy'
      }
    
    text.on 'activate', =>
      if editor.kit.active?.key is 'scale'
        @_scalable = scalable()
    text.on 'deactivate', =>
      if editor.kit.active?.key is 'scale'
        @_scalable?.destroy?()
    
    editor.kit.on 'activate', ({key}) =>
      if key is 'scale'
        if slot.texts.active is text
          @_scalable = scalable()
    
    editor.kit.on 'deactivate', ({key}) =>
      if key is 'scale'
        if slot.texts.active is text
          @_scalable?.destroy?()
  
  selectable: ->
    
    {text} = this
    
    {slot} = text
    
    slot.zIndexText ?= 666
    
    bringToTop = =>
      slot.zIndexText++
      @dom.css 'z-index': slot.zIndexText
    
    @on 'interact', =>
      slot.texts.activate text
    
    select = =>
      bringToTop()
      @dom.css 'box-shadow': '0px 0px 0px 3px #8ac53f'
    
    deselect = =>
      @dom.css 'box-shadow': ''
    
    slot.texts.on 'activate', (_text) =>
      if _text is text
        select()
    
    slot.texts.on 'deactivate', (_text) =>
      if _text is text
        deselect()
    
    @dom.on 'mousedown', (event) =>
      event.preventDefault()
      @emit 'interact'
  
  fit: ->
    `
    jQuery.fn.textfill = function(options) {
        var fontSize = options.maxFontPixels;
        var ourText = jQuery('span:visible:first', this);
        var maxHeight = jQuery(this).height();
        var maxWidth = jQuery(this).width();
        var textHeight;
        var textWidth;
        do {
            ourText.css('font-size', fontSize);
            textHeight = ourText.height();
            textWidth = ourText.width();
            fontSize = fontSize - 1;
        } while ((textHeight > maxHeight || textWidth > maxWidth) && fontSize > 3);
        return this;
    }
    `
    
    @dom.textfill maxFontPixels: 120
  
  deletable: ->
    
    dom = jQuery '<div>'
    dom.appendTo @dom
    dom.css
      width: 20
      height: 20
      top: -10
      right: -10
      position: 'absolute'
      'line-height': 20
      'font-size': 20
      'z-index': 1000
    dom.addClass 'ui-handle-delete'
    
    dom.click (event) =>
      event.preventDefault()
      # graphic.slot.graphics.remove graphic
      @dom.remove()
  
  show: ->
    
    @dom.show()
    
    @emit 'show'
  
  hide: ->
    
    @dom.hide()
    
    @emit 'hide'