async = require 'async'
util = require 'util'

module.exports = (clone, filters, callback) ->
  
  # editor.filters =
  #   sepia: 0
  #   brightness: 0
  #   saturate: 0
  #   'hue-rotate': 0
  #   contrast: 0
  #   blur: 0
  #   lightness: 0
  #   temperature: 0
  
  async.waterfall [
    #apply some focus
    (callback) ->
      #if focus doesn't exist then use blur
      if filters.blur is 0
        console.log 'no blur'
        callback null, clone

      #blur
      else if filters.blur < 0
        console.log 'applying some blur', filters.blur * -0.05
        Pixastic.process clone, 'blurfast', amount: filters.blur * -0.05, (canvas) ->
          console.log 'blur done'
          callback null, canvas

      #sharpen
      else
        console.log 'applying some sharpening', filters.blur * 0.01
        Pixastic.process clone, 'sharpen', amount: filters.blur * 0.01, (canvas) ->
          console.log 'sharpen done'
          callback null, canvas

    #apply brightness and sharpness
    (clone, callback) ->
      if filters.brightness is 0 and filters.contrast is 0
        console.log 'no brightness/contrast'
        callback null, clone

      else
        brightness = filters.brightness * 1.5
        contrast = filters.contrast

        if contrast < 0 then contrast *= 0.01
        if contrast > 0 then contrast *= 0.05

        console.log 'applying some brightness/contrast', "brightness: #{brightness}, contrast: #{contrast}"
        Pixastic.process clone, 'brightness', {brightness: brightness, contrast: contrast}, (canvas) ->
          console.log 'brightness/contrast done'
          callback null, canvas

    #apply sepia
    (clone, callback) ->
      if filters.sepia <= 0
        console.log 'no sepia'
        callback null, clone

      else
        console.log 'applying sepia', filters.sepia
        Pixastic.process clone, 'sepia', sepia: filters.sepia, (canvas) ->
          console.log 'sepia done'
          callback null, canvas

    #apply temperature
    (clone, callback) ->
      if filters.temperature is 0
        console.log 'no temperature'
        callback null, clone

      else
        color = filters.temperature
        red = 0.001 * color
        green = -0.001 * color
        blue = -0.001 * color

        console.log 'applying temperature', "red: #{red}, green: #{green}, blue: #{blue}"
        Pixastic.process clone, 'coloradjust', {red: red, green: green, blue: blue}, (canvas) ->
          console.log 'temperature done'
          callback null, canvas

    #apply some saturation
    (clone, callback) ->
      if filters['hue-rotate'] is 0 and filters.saturate is 0 and filters.lightness is 0
        console.log 'no hsl'
        callback null, clone

      else
        console.log 'applying some hsl', "hue: #{filters['hue-rotate']}, saturate: #{filters.saturate}, lightness: #{filters.lightness}"
        Pixastic.process clone, 'hsl', {hue: filters['hue-rotate'], saturation: filters.saturate, lightness:filters.lightness}, (canvas) ->
          console.log 'hsl done'
          callback null, canvas

  ], (err, canvas) ->
    #if canvas.nodeName.toLowerCase() is 'canvas' then window.open canvas.toDataURL()
    callback err, canvas

  