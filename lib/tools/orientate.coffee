Tool = require '../tool'

module.exports = class Orientate extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    rotate = (delta) =>
      for key, graphic of @kit.editor.graphics.objects
        
        graphic.rotation ?= 0
        graphic.rotation += delta
        
        graphic.dom.css
          transform: "rotate(#{graphic.rotation}deg)"
    
    (jQuery '#orientation-clockwise').click (event) =>
      event.preventDefault()
      rotate 90
    
    (jQuery '#orientation-anticlockwise').click (event) =>
      event.preventDefault()
      rotate -90
    
    mirror = (dimension) =>
      event.preventDefault()
      
      for key, graphic of @kit.editor.graphics.objects
        
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
  
  activate: ->
    
    # for key, graphic of @kit.editor.graphics.objects
    
    # graphic.showCrop()
    
    (jQuery '#tool-orientation').fadeIn()
  
  deactivate: ->
    
   (jQuery '#tool-orientation').fadeOut()