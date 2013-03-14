_ = require 'underscore'

module.exports = (editor, args, context) ->
  
  editor.filters = {}
  
  editor.defaultFilters = ->
    sepia: 0
    brightness: 0
    saturation: 0
    'hue-rotate': 0
    contrast: 0
    blur: 0
    lightness: 0
    temperature: 0
    focus: 0
  
  editor.getFilters = ->
    filters = {}
    for key, filter of editor.filters
      filters[key] = filter
    return filters
  
  editor.resetFilters = ->
    editor.setFilters editor.defaultFilters()
  
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
  
  effects = require './pixastic/index'
  
  imageDataToCanvas = (imageData) ->
    canvas = document.createElement 'canvas'
    canvas.width = imageData.width
    canvas.height = imageData.height
    (canvas.getContext '2d').putImageData imageData, 0, 0
    return canvas
  
  imageToCanvas = (image) ->
    canvas = document.createElement 'canvas'
    canvas.width = image.width
    canvas.height = image.height
    (canvas.getContext '2d').drawImage image, 0, 0
    return canvas
  
  createImageData = (ctx, width, height) ->
    if ctx.createImageData?
      ctx.createImageData width, height
    else
      ctx.getImageData 0, 0, width, height
  
  # getImageData = (ctx, callback) ->
  #   try
  #     imageData = ctx.getImageData 0, 0, width, height
  #     callback null, imageData
  #   catch e
  #     if location.protocol is 'file:'
  #       callback 'Could not access image data, running from file://'
  #     else
  #      callback 'Could not access image data, is canvas tainted by cross-origin data?'
  
  editor.ui.on 'slider', (key, value) ->
    map =
      saturate: 'saturation'
      brightness: 'lightness'
      blur: 'focus'
      sharpness: 'focus'
    key = map[key] or key
    editor.setFilter key, value
  
  editor.pushFilters = ->
    
    console.log 'pushing', JSON.stringify editor.filters
    
    profile = editor.profiles.active
    project = profile.projects.active
    layout = project.layouts.active
    
    layout.slots.map (key, slot) =>
      
      slot.graphics.map (key, graphic) =>
        
        {width, height} = graphic.image
        
        canvas = imageToCanvas graphic.image
        # (jQuery canvas).appendTo document.body
        
        ctx = canvas.getContext '2d'
        
        inData = ctx.getImageData 0, 0, width, height
        outData = createImageData ctx, width, height
        
        [inData, outData] = [outData, inData]
        
        if editor.filters.saturation isnt 0 or editor.filters.lightness isnt 0
          [inData, outData] = [outData, inData]
          effects.hsl inData.data, outData.data, width, height,
            hue: 0
            saturation: editor.filters.saturation / 100
            lightness: editor.filters.lightness / 100
        
        if 0 < editor.filters.focus < 100
          [inData, outData] = [outData, inData]
          effects.sharpen5x5 inData.data, outData.data, width, height, strength: editor.filters.focus / 100
        
        if -100 < editor.filters.focus < 0
          [inData, outData] = [outData, inData]
          effects.blur inData.data, outData.data, width, height, kernelSize: Math.floor (-editor.filters.focus / 10)
        
        if -100 < editor.filters.temperature < 0
          [inData, outData] = [outData, inData]
          effects.colorfilter inData.data, outData.data, width, height,
            r: editor.filters.temperature / 200
            g: -editor.filters.temperature / 200
            b: -editor.filters.temperature / 100
        
        if 0 < editor.filters.temperature < 100
          [inData, outData] = [outData, inData]
          effects.colorfilter inData.data, outData.data, width, height,
            r: editor.filters.temperature / 100
            g: -editor.filters.temperature / 200
            b: -editor.filters.temperature / 100
        
        if editor.filters.contrast isnt 0
          [inData, outData] = [outData, inData]
          effects.brightness inData.data, outData.data, width, height,
            contrast: editor.filters.contrast / 100
        
        ctx.putImageData outData, 0, 0
        graphic.emit 'src', canvas.toDataURL()
  
  editor.filters = editor.defaultFilters()
  
  # window.nocanvas = false
  # if window.location.search.indexOf('nocanvas') != -1
  #   window.nocanvas = true
  
  # supportsCanvas = !!window.HTMLCanvasElement && !nocanvas
  
  # console.log 'HTMLCanvasElement', supportsCanvas
  
  # editor.buildCSS = ->
  #   parts = ("#{key}(#{value})" for own key, value of editor.filters)
  #   return parts.join ' '
    
  # editor.buildQueryString = ->
  #   parts = ("#{key}=#{value}" for own key, value of editor.filters)
  #   return parts.join '&'
  
  # editor.pushFilters = ->
  #   if supportsCanvas
  #     editor.normalPushFilters()
  #   else
  #     editor.throttlePushFilters()
  
  # editor.throttlePushFilters = _.throttle ->
  #   editor.graphics.map (key, graphic) ->
  #     id = graphic.dom.find('img').attr 'id'
  #     host = "http://#{window.location.hostname}:8080"
  #     graphic.image.src = "#{host}/uploads/#{id}?#{editor.buildQueryString()}"
  # , 1000
  
  # editor.normalPushFilters = _.throttle ->
  #   editor.graphics.map (key, graphic) ->
  #     running = false #dirty hack
  #     graphic.clone.onload = ->
  #       if !running #dirty hack
  #         running = true
  #         (require './phantom') graphic.clone, editor.filters, (err, el) ->
  #           if !err?
  #             if el.nodeName.toLowerCase() is 'img'
  #               graphic.image = el
  #             else if el.nodeName.toLowerCase() is 'canvas'
  #               graphic.dom.find('img').attr 'src', el.toDataURL()
  #           else
  #             console.log 'phantom failed for', id, editor.filters
  #     id = graphic.dom.find('img').attr 'id'
  #     url = id.replace /_/g, '/'
  #     graphic.clone.src = "/uploads/#{url}"
  # , 250 #100ms for local
  
  # editor.pushFilters()
  
  # editor.on 'graphic', (graphic) ->
  #   editor.pushFilters()