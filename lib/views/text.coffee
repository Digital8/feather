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
      width: @parent.width() * @text.relative.width
      height: @parent.height() * @text.relative.height
      top: @parent.height() * @text.offset.top
      left: @parent.width() * @text.offset.left
      'text-align': 'center'
      'vertical-align': 'middle'
      'z-index': 1000
      'box-sizing': 'content-box'
    
    @dom.appendTo @parent
    
    @span = jQuery '<span>'
    @span.css
      'line-height': 1
      'font-family': @text.font
      color: @text.color
    @span.appendTo @dom
    
    @span.html @text.value
    
    @fit()
    
    @text.on 'color', (color) =>
      @span.css color: color
      @fit()
    
    @text.on 'font', (font) =>
      @span.css 'font-family': font
      @fit()
    
    @text.on 'value', (value) =>
      @span.html value
      @fit()
    
    if @mode is 'write'
      @dom.draggable
        drag: =>
          @text.offset =
            left: @dom.position().left / @parent.width()
            top: @dom.position().top / @parent.height()
          @text.emit 'move'
          
          @emit 'interact'
      
      @deletable()
      @selectable()
      @scalable()
      
      @on 'fit', =>
        @text.box =
          left: @span.position().left / @parent.width()
          top: @span.position().top / @parent.height()
          width: @span.width() / @parent.width()
          height: @span.height() / @parent.height()
    
    @fit()
    
    @text.on 'activate', =>
      @editor.ui.emit 'text', @text
    
    @text.on 'resize', =>
      @dom.css
        width: @parent.width() * @text.relative.width
        height: @parent.height() * @text.relative.height
      @fit()
    
    @text.on 'move', =>
      @dom.css
        left: @text.offset.left * @parent.width()
        top: @text.offset.top * @parent.height()
      @fit()
    
    @text.on 'resize', =>
      @fit()
  
  scalable: ->
    
    {editor, text} = this
    
    {slot} = text
    
    scalable = =>
      
      resizable = @dom.resizable
        handles: 'all'
        resize: =>
          @text.relative =
            width: @dom.width() / @parent.width()
            height: @dom.height() / @parent.height()
          @text.emit 'resize'
          
          @text.offset =
            left: @dom.position().left / @parent.width()
            top: @dom.position().top / @parent.height()
          @text.emit 'move'
          
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
    
    slot.zIndexText ?= 1666
    
    bringToTop = =>
      slot.zIndexText++
      @dom.css 'z-index': slot.zIndexText
    
    @on 'interact', =>
      slot.texts.activate text
    
    border = ({color, width}) ->
      border: "#{color} #{width}px solid"
    
    select = =>
      bringToTop()
      @dom.css (border color: '#b4ebfc', width: 3)
    
    deselect = =>
      @dom.css (border color: '#b4ebfc', width: 0)
    
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
    
    @dom.find('span').css 'line-height', "#{@dom.height()}px"
    
    @emit 'fit'
  
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
      @text.slot.texts.remove @text
      @dom.remove()
      @editor.kit.deactivate()
  
  show: ->
    
    @dom.show()
    
    @emit 'show'
  
  hide: ->
    
    @dom.hide()
    
    @emit 'hide'