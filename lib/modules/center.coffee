module.exports = (editor) ->
  
  # editor.center = (graphic) ->
  
  #   delta =
  #     width: graphic.width - editor.surface.data.width
  #     height: graphic.height - editor.surface.data.height
    
  #   graphic.dom.css
  #     left: -(delta.width / 2)
  #     top: -(delta.height / 2)
  
  editor.center = ({parent, child}) ->
    
    return {
      left: -((child.width - parent.width) / 2)
      top: -((child.height - parent.height) / 2)
    }