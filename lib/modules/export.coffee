module.exports = (editor) ->
  
  editor.export = ->
    
    save = {}
    save.graphics = {}
    
    editor.graphics.map (key, graphic) ->
      save.graphics[key] = graphic.save()
    
    save.filters = editor.getFilters()
    
    localStorage.project = JSON.stringify save
    
    return save