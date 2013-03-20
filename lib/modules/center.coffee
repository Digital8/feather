module.exports = (editor) ->
  
  editor.center = ({parent, child}) ->
    
    out =
      left: -((child.width - parent.width) / 2)
      top: -((child.height - parent.height) / 2)
    
    return out