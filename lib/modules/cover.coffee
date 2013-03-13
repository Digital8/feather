module.exports = (editor) ->
  
  editor.cover = ({parent, child}) ->
    
    if child.aspect < parent.aspect
      scale = parent.width / child.width
    if child.aspect > parent.aspect
      scale = parent.height / child.height
    
    out = {
      width: child.width * scale
      height: child.height * scale
      scale: scale
    }
    
    out.aspect = out.width / out.height
    
    return out