Tool = require '../tool'

module.exports = class Orientation extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    rotate = (delta) =>
      return unless @selected?
      
      graphic = @selected
      
      delta *= 100000
      delta = Math.round delta
      delta /= 100000
      
      graphic.theta += delta
      
      graphic.pushTransform()
      
      return
    
    (jQuery '#orientation-clockwise').click (event) =>
      event.preventDefault()
      rotate Math.PI / 2
    
    (jQuery '#orientation-anticlockwise').click (event) =>
      event.preventDefault()
      rotate -(Math.PI / 2)
    
    mirror = (dimension) =>
      return unless @selected?
      
      graphic = @selected
      
      graphic.scale[dimension] *= -1
      
      graphic.pushTransform()
    
    (jQuery '#orientation-vertical').click (event) =>
      event.preventDefault()
      mirror 1
    
    (jQuery '#orientation-horizontal').click (event) =>
      event.preventDefault()
      mirror 0
    
    @kit.editor.ui.stage.click =>
      for key, graphic of @kit.editor.graphics.objects
        graphic.dom.css
          'box-shadow': ''
          '-webkit-box-shadow': ''
        
        (jQuery '#tool-orientation').find('.icon').css opacity: 0.5
      
      @selected = null
    
    @kit.editor.on 'graphic', (graphic) =>
      
      graphic.theta ?= 0
      graphic.scale ?= [1, 1]
      
      graphic.dom.click (event) =>
        
        return unless @kit.active is this
        
        event.stopPropagation()
        
        for key, _graphic of @kit.editor.graphics.objects
          _graphic.dom.css
            'box-shadow': ''
            '-webkit-box-shadow': ''
        
        graphic.dom.css
          'box-shadow':         '0px 0px 0px 3px #8ac53f'
          '-webkit-box-shadow': '0px 0px 0px 3px #8ac53f'
        
        (jQuery '#tool-orientation').find('.icon').css opacity: 1
        
        @selected = graphic
      
      graphic.pushTransform = =>
        
        parts = [
          graphic.scale[0] * (Math.cos graphic.theta)
          graphic.scale[1] * (Math.sin graphic.theta)
          graphic.scale[0] * -1 * (Math.sin graphic.theta)
          graphic.scale[1] * (Math.cos graphic.theta)
          0
          0
        ]
        
        matrix = parts.join ', '
        
        graphic.dom.css
          '-moz-transform':    "matrix(#{matrix})"
          '-webkit-transform': "matrix(#{matrix})"
          '-o-transform':      "matrix(#{matrix})"
  
  activate: ->
    
    super
    
    (jQuery '#tool-orientation').find('.icon').css opacity: 0.5
  
  deactivate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      graphic.dom.css border: 'none'