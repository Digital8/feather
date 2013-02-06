Tool = require '../tool'

module.exports = class Orientation extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    rotate = (delta) =>
      return unless @selected?
      
      graphic = @selected
      
      graphic.rotation ?= 0
      graphic.rotation += delta
      
      graphic.dom.css
        transform: "rotate(#{graphic.rotation}deg)"
      
      return
    
    (jQuery '#orientation-clockwise').click (event) =>
      event.preventDefault()
      rotate 90
    
    (jQuery '#orientation-anticlockwise').click (event) =>
      event.preventDefault()
      rotate -90
    
    mirror = (dimension) =>
      return unless @selected?
      
      graphic = @selected
      
      graphic.scale ?= [1, 1]
      
      graphic.scale[dimension] *= -1
      
      graphic.dom.css
        '-moz-transform':    "matrix(#{graphic.scale[0]}, 0, 0, #{graphic.scale[1]}, 0, 0)"
        '-webkit-transform': "matrix(#{graphic.scale[0]}, 0, 0, #{graphic.scale[1]}, 0, 0)"
        '-o-transform':      "matrix(#{graphic.scale[0]}, 0, 0, #{graphic.scale[1]}, 0, 0)"
    
    (jQuery '#orientation-vertical').click (event) =>
      event.preventDefault()
      mirror 1
    
    (jQuery '#orientation-horizontal').click (event) =>
      event.preventDefault()
      mirror 0
    
    @kit.editor.ui.stage.click =>
      for key, graphic of @kit.editor.graphics.objects
        graphic.dom.css border: 'none'
        
        (jQuery '#tool-orientation').find('.icon').css opacity: 0.5
      
      @selected = null
    
    @kit.editor.on 'graphic', (graphic) =>
      
      graphic.dom.click (event) =>
        
        return unless @kit.active is this
        
        event.stopPropagation()
        
        for key, _graphic of @kit.editor.graphics.objects
          _graphic.dom.css border: 'none'
        
        graphic.dom.css border: '3px solid #8ac53f'
        
        (jQuery '#tool-orientation').find('.icon').css opacity: 1
        
        @selected = graphic
  
  activate: ->
    
    super
    
    (jQuery '#tool-orientation').find('.icon').css opacity: 0.5
  
  deactivate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      graphic.dom.css border: 'none'