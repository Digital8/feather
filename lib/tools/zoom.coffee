Tool = require '../tool'

module.exports = class Zoom extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @zoom = (factor) =>
      
      selected = @editor.augmentations.get('select')?.selected
      
      return unless selected?
      
      selected.zoom ?= 1
      selected.zoom *= factor
      
      @pushZoom selected
    
    @pushZoom = (graphic) ->
      
      {dom, image, clone, zoom} = graphic
      
      oldCenter = [dom.position().left + (dom.width() / 2), dom.position().top + (dom.height() / 2)]
      
      width = clone.width * zoom
      height = clone.height * zoom
      
      dom.css
        width: width
        height: height
      
      dom.css
        left: oldCenter[0] - (width / 2)
        top: oldCenter[1] - (height / 2)
      
      @emit 'zoom'
    
    (jQuery '#zoom-out').click (event) =>
      event.preventDefault()
      @zoom 0.9
    
    (jQuery '#zoom-in').click =>
      event.preventDefault()
      @zoom 1.1
    
    @center = (graphic) =>
      {dom, image} = graphic
      
      save = graphic.save()
      
      {width, height, top, left} = save.css
      
      if image.width > @editor.surface.data.width
        diff = [
          image.width - @editor.surface.data.width
          image.height - @editor.surface.data.height
        ]
        
        diff[0] /= 2
        diff[1] /= 2
        
        save.css.left = -diff[0]
        save.css.top = -diff[1]
      
      graphic.dom.css save.css
  
  fit: (graphic) ->
    
    {image, dom} = graphic
    
    stage =
      width: @editor.surface.data.width
      height: @editor.surface.data.height
    
    stage.aspect = stage.width / stage.height
    
    image.aspect = image.width / image.height
    
    if image.aspect < stage.aspect
      scale = stage.width / image.width
    else if image.aspect >= stage.aspect
      scale = stage.height / image.height
    
    image.width *= scale
    image.height *= scale
    
    graphic.zoom = scale
    
    @pushZoom graphic
    
    @center graphic
    
    # if image.height > stage.height
      
    #   dom.css
    #     top: -((image.height - stage.height) / 2) 
    
    # if image.width > stage.width
    #   dom.css
    #     left: -((image.width - stage.width) / 2)
    
    dom.css
      zIndex: 1000000