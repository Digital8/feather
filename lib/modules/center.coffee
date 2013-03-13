module.exports = (editor) ->
  
  editor.center = ({parent, child}) ->
    
    return {
      left: -((child.width - parent.width) / 2)
      top: -((child.height - parent.height) / 2)
    }