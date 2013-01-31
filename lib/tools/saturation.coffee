Tool = require '../tool'

module.exports = class Text extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    (jQuery "#text-value").keydown (event) =>
      @setText (jQuery event.target).val()
  
  setText: (text) ->
    @text.text text
    @emit 'setText', text
  
  activate: ->
    
    @text = jQuery """<p>"""
    @text.text Math.random()
    @text.appendTo @editor.stage
  
  deactivate: ->
    
    @text?.remove()
    
    # rotate = (delta) =>
    #   for key, graphic of @kit.editor.graphics.objects
        
    #     graphic.rotation ?= 0
    #     graphic.rotation += delta
        
    #     graphic.dom.css
    #       transform: "rotate(#{graphic.rotation}deg)"
    
    # (jQuery '#orientation-clockwise').click (event) =>
    #   event.preventDefault()
    #   rotate 90
    
    # (jQuery '#orientation-anticlockwise').click (event) =>
    #   event.preventDefault()
    #   rotate -90
    
    # mirror = (dimension) =>
    #   event.preventDefault()
      
    #   for key, graphic of @kit.editor.graphics.objects
        
    #     graphic.scale ?= [1, 1]
        
    #     graphic.scale[dimension] *= -1
        
    #     graphic.dom.css
    #       '-moz-transform':    "matrix(#{graphic.scale[0]}, 0, 0, #{graphic.scale[1]}, 0, 0)"
    #       '-webkit-transform': "matrix(#{graphic.scale[0]}, 0, 0, #{graphic.scale[1]}, 0, 0)"
    #       '-o-transform':      "matrix(#{graphic.scale[0]}, 0, 0, #{graphic.scale[1]}, 0, 0)"
    
    # (jQuery '#orientation-vertical').click (event) =>
    #   event.preventDefault()
    #   mirror 1
    
    # (jQuery '#orientation-horizontal').click (event) =>
    #   event.preventDefault()
    #   mirror 0
  
  activate: ->
    # (jQuery '#tool-saturation').stop().fadeIn 'swift'
  
  deactivate: ->
    # (jQuery '#tool-saturation').stop().fadeOut 'swift'