module.exports = (editor) ->
  
  editor.save = ->
    
    save = {}
    save.graphics = {}
    
    editor.graphics.map (key, graphic) ->
      save.graphics[key] = graphic.save()
    
    save.filters = editor.getFilters()
    
    localStorage.project = JSON.stringify save
    
    return save