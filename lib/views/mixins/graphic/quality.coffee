module.exports = (graphicController) ->
  
  {graphic, view} = graphicController
  
  {slot} = graphic
  
  qualityKeyToColor = (key) ->
    {
      perfect: 'green'
      average: 'orange'
      poor: 'red'
    }[key]
  
  border = ({color, width}) ->
    border: "#{color} #{width}px solid"
  
  graphic.on 'quality', ->
    
    return unless slot.graphics.active isnt graphic
    
    view.dom.css border
      color: qualityKeyToColor graphic.quality.key
      width: 3
  
  slot.graphics.on 'deactivate', (_graphic) ->
    
    return unless _graphic is graphic
    
    view.dom.css border
      color: qualityKeyToColor graphic.quality.key
      width: 3