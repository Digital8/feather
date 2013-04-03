module.exports = (graphicController) ->
  
  {graphic, view} = graphicController
  
  {slot} = graphic
  
  qualityKeyToColor = (key) ->
    {
      perfect: 'green'
      average: 'orange'
      poor: 'red'
    }[key]
  
  graphic.on 'quality', ->
    
    return unless slot.graphics.active isnt graphic
    
    color = qualityKeyToColor graphic.quality.key
    
    view.dom.css 'box-shadow': "0px 0px 0px 3px #{color}"
  
  slot.graphics.on 'deactivate', (_graphic) ->
    
    return unless _graphic is graphic
    
    color = qualityKeyToColor graphic.quality.key
    
    view.dom.css 'box-shadow': "0px 0px 0px 3px #{color}"