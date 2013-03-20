module.exports = (editor) ->
  
  editor.contain = ({parent, child}) ->
    
    ratio = Math.min.apply Math, [
      parent.width / child.width
      parent.height / child.height
    ]
    
    out =
      width: child.width * ratio
      height: child.height * ratio
    
    out.aspect = out.width / out.height
    
    return out