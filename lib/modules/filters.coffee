_ = require 'underscore'

module.exports = (editor, args, {console}) ->
  
  window.nocanvas = false
  if window.location.search.indexOf('nocanvas') != -1
    window.nocanvas = true
  
  supportsCanvas = !!window.HTMLCanvasElement && !nocanvas
  
  console.log 'HTMLCanvasElement', supportsCanvas
  
  editor.filters = {}
  
  editor.getFilters = ->
    filters = {}
    for key, filter of editor.filters
      filters[key] = filter
    return filters
  
  editor.resetFilters = ->
    
    editor.filters =
      sepia: 0
      brightness: 0
      saturate: 0
      'hue-rotate': 0
      contrast: 0
      blur: 0
      lightness: 0
      temperature: 0
  
  editor.resetFilters()
  
  editor.buildCSS = ->
    parts = ("#{key}(#{value})" for own key, value of editor.filters)
    return parts.join ' '
    
  editor.buildQueryString = ->
    parts = ("#{key}=#{value}" for own key, value of editor.filters)
    return parts.join '&'
  
  editor.pushFilters = ->
    if supportsCanvas
      editor.normalPushFilters()
    else
      editor.throttlePushFilters()
  
  editor.throttlePushFilters = _.throttle ->
    editor.graphics.map (key, graphic) ->
      id = graphic.dom.find('img').attr 'id'
      host = "http://#{window.location.hostname}:8080"
      graphic.image.src = "#{host}/uploads/#{id}?#{editor.buildQueryString()}"
  , 1000
  
  editor.normalPushFilters = _.throttle ->
    editor.graphics.map (key, graphic) ->
      running = false #dirty hack
      graphic.clone.onload = ->
        if !running #dirty hack
          running = true
          (require './phantom') graphic.clone, editor.filters, (err, el) ->
            if !err?
              if el.nodeName.toLowerCase() is 'img'
                graphic.image = el
              else if el.nodeName.toLowerCase() is 'canvas'
                graphic.dom.find('img').attr 'src', el.toDataURL()
            else
              console.log 'phantom failed for', id, editor.filters
      id = graphic.dom.find('img').attr 'id'
      url = id.replace /_/g, '/'
      graphic.clone.src = "/uploads/#{url}"
  , 250 #100ms for local
  
  editor.pushFilters()
  
  editor.on 'graphic', (graphic) ->
    editor.pushFilters()
  
  editor.setFilter = (key, value) ->
    editor.filters[key] = value
    editor.pushFilters()
  
  editor.setFilters = (map) ->
    for key, value of map
      editor.filters[key] = value
    editor.pushFilters()
  
  editor.preset = null
  
  editor.setPreset = (preset) ->
    
    if editor.preset?
      old = editor.preset
      editor.preset = null
      editor.emit 'unpreset', old
    
    editor.resetFilters()
    map = preset.exec()
    editor.setFilters map
    
    editor.preset = preset
    
    editor.emit 'preset', preset