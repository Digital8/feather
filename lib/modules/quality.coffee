module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.computeQuality = ->
      {dom} = graphic
      
      width = dom.width()
      height = dom.height()
      
      ratios =
        width: width / graphic.initial.width
        height: height / graphic.initial.height
      
      if (ratios.width < 1.25) and (ratios.height < 1.25)
        
        graphic.emit 'quality', 'perfect'
      
      if (1.5 < ratios.width < 2) or (1.5 < ratios.height < 2)
        
        graphic.emit 'quality', 'average'
      
      if (ratios.width > 1.75) or (ratios.height > 1.75)
        
        graphic.emit 'quality', 'poor'
    
    graphic.on 'zoom', ->
      graphic.computeQuality()
    
    graphic.on 'resize', ->
      graphic.computeQuality()
    
    graphic.computeQuality()