Tool = require '../tool'

module.exports = class Crop extends Tool
  
  constructor: (args = {}) ->
    
    super
  
  activate: ->
    
    super
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.showCrop()
  
  deactivate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.hideCrop()
  
  commit: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      unless graphic.crop.width? and graphic.crop.height? and graphic.crop.top? and graphic.crop.left?
        
        graphic.hideCrop()
      
      else
        
        url = @kit.editor.operations.get('crop').operate
          width: graphic.crop.width
          height: graphic.crop.height
          
          left: graphic.crop.left
          top: graphic.crop.top
          
          image: graphic.image
        
        graphic.image.src = url
        
        {top, left} = graphic.dom.position()
        
        graphic.dom.css
          left: graphic.crop.left + left
          top: graphic.crop.top + top
          
          width: graphic.crop.width
          height: graphic.crop.height
        
        graphic.$crop.css
          left: 0
          top: 0
          
          width: graphic.crop.width
          height: graphic.crop.height
        
        graphic.hideCrop()