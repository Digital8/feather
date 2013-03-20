module.exports = (editor) ->
  
  editor.margin = ({parent, child, margin}) ->
    
    out = margin: {x: null, y: null}
    
    debugger
    
    if child.aspect > parent.aspect
      out.margin.x = Math.floor margin.x * parent.aspect
      scale = child.width / (parent.width - 2 * margin.x)
      height = child.height / scale
      out.margin.y = Math.floor (parent.height - height) / 2
    else
      out.margin.y = margin.y
      scale = child.height / (parent.height - 2 * margin.y)
      width = child.width / scale
      out.margin.x = Math.floor (parent.width - width) / 2
    
    out =
      top: out.margin.y
      left: out.margin.x
      width: parent.width - (2 * out.margin.x)
      height: parent.height - (2 * out.margin.y)
    
    delete out.margin
    
    out.aspect = out.width / out.height
    
    return out