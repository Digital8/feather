module.exports = (editor, args, context) ->
  
  editor.ui.on 'slider', (key, value) ->
    map =
      saturate: 'saturation'
      brightness: 'lightness'
      blur: 'focus'
      sharpness: 'focus'
    key = map[key] or key
    
    editor.ui.emit 'filter', key, value
  
  editor.profiles.map (key, profile) ->
    
    profile.projects.on 'add', (project) ->
      
      project.layouts.on 'add', (layout) ->
        
        layout.slots.on 'add', (slot) ->
          
          (require './filterify') slot
        
        layout.slots.map (key, slot) ->
          
          (require './filterify') slot
          
          slot.filters.on 'change', ->
            
            slot.graphics.map (key, graphic) ->
              
              (require './process_graphic') graphic: graphic, filters: slot.filters.all()
          
          slot.graphics.on 'add', (graphic) ->
            
            (require './process_graphic') graphic: graphic, filters: slot.filters.all()
  
  editor.ui.on 'filter', (key, value) ->
    
    slot = editor.profiles.active?.projects.active?.layouts.active?.slots.active
    
    slot.filters.set key, value
  
  editor.ui.on 'preset', (key, preset) ->
    
    slot = editor.profiles.active?.projects.active?.layouts.active?.slots.active
    
    slot.filters.preset preset