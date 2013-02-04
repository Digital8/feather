Tool = require '../tool'

module.exports = class Crop extends Tool
  
  constructor: (args = {}) ->
    
    super
  
  activate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.showCrop()
  
  deactivate: ->
    
    for key, graphic of @kit.editor.graphics.objects
      
      graphic.hideCrop()
  
  commit: ->
    
    console.log 'commit crop'
    
    for key, graphic of @kit.editor.graphics.objects
      
      {width, height} = graphic.size
      
      # graphic.element.css
      #   # width: width
      #   # height: height
      #   # 'background-position'
      #   top: -graphic.position.top
      #   left: -graphic.position.left
      #   position: 'absolute'
      #   width: graphic.original.width
      #   height: graphic.original.height
      
      graphic.dom.css
        left: graphic.dom.position().left + graphic.position.left
        top: graphic.dom.position().top + graphic.position.top
        # overflow: 'hidden'
        width: graphic.size.width
        height: graphic.size.height
      
      graphic.hideCrop()