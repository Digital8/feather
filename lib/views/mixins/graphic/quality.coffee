module.exports = (graphicController) ->
  
  {graphic, view} = graphicController
  
  qualityKeyToColor = (key) ->
    {
      perfect: 'green'
      average: 'orange'
      poor: 'red'
    }[key]
  
  graphic.on 'quality', ({key, value}) ->
    
    color = qualityKeyToColor key
    
    view.dom.css 'box-shadow': "0px 0px 0px 3px #{color}"