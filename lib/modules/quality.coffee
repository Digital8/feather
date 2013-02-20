module.exports = (editor) ->
  
  editor.quality = (rating) ->
    
    toolIndicator = jQuery '#indicator'
    captionHeading = jQuery '#indicator-heading'
    captionParagraph = jQuery '#indicator-paragraph'
    toolIndicatorAlert = jQuery '#indicator-alert'
    
    toolIndicator.removeClass 'poor average perfect'
    toolIndicator.addClass rating
  
  editor.on 'graphic', (graphic) ->
    
    graphic.computeQuality = ->
      {dom} = graphic
      
      width = dom.width()
      height = dom.height()
      
      ratios =
        width: width / graphic.initial.width
        height: height / graphic.initial.height
      
      if (ratios.width < 1.25) and (ratios.height < 1.25)
        
        editor.quality 'perfect'
      
      if (1.5 < ratios.width < 2) or (1.5 < ratios.height < 2)
        
        editor.quality 'average'
      
      if (ratios.width > 1.75) or (ratios.height > 1.75)
        
        editor.quality 'poor'
    
    graphic.on 'zoom', ->
      graphic.computeQuality()
    
    graphic.on 'resize', ->
      graphic.computeQuality()
    
    graphic.computeQuality()
  
  # captionHeading.html 'Perfect!'
  
  # captionParagraph.html 'Your image is perfect for printing.'
  
  # if box? && box != false then toolIndicatorAlert.fadeIn 150
  # else toolIndicatorAlert.fadeOut 150