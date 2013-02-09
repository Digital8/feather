Tool = require '../tool'

module.exports = class Orientation extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    rotate = (direction, delta) =>
      selected = @editor.augmentations.get('select').selected
      
      return unless selected?
      
      graphic = selected
      
      graphic.theta += delta
      
      while graphic.theta > (Math.PI * 2)
        graphic.theta -= (Math.PI * 2)
      
      while graphic.theta < 0
        graphic.theta += (Math.PI * 2)
      
      @_commit 'rotate', direction
      
      return
    
    (jQuery '#orientation-clockwise').click (event) =>
      event.preventDefault()
      rotate 'clockwise', Math.PI / 2
    
    (jQuery '#orientation-anticlockwise').click (event) =>
      event.preventDefault()
      rotate 'anticlockwise', -(Math.PI / 2)
    
    mirror = (dimension) =>
      return unless @selected?
      
      graphic = @selected
      
      graphic.scale[dimension] *= -1
      
      graphic.pushTransform()
    
    (jQuery '#orientation-vertical').click (event) =>
      event.preventDefault()
      mirror 1
    
    (jQuery '#orientation-horizontal').click (event) =>
      event.preventDefault()
      mirror 0
    
    @kit.editor.on 'graphic', (graphic) =>
      
      graphic.theta ?= 0
        
      graphic.on 'select', =>
        @enable()
      
      graphic.on 'deselect', =>
        @disable()
  
  enable: ->
    (jQuery '#tool-orientation').find('.icon').css opacity: 1
  
  disable: ->
    (jQuery '#tool-orientation').find('.icon').css opacity: 0.5
  
  activate: ->
    
    super
    
    if @kit.editor.augmentations.get('select').selected?
        @enable()
    else
      @disable()
  
  deactivate: ->
    
    super
    
    @disable()
  
  _commit: (op, args) ->
    graphic = @editor.augmentations.get('select').selected
    
    save = graphic.save()
    
    operation = @editor.operations.get 'rotate'
    
    {url, width, height} = operation.operate graphic: graphic
    
    oldCenterX = save.css.left + (save.css.width / 2)
    oldCenterY = save.css.top + (save.css.height / 2)
    
    graphic.image.src = url
    graphic.dom.css
      left: oldCenterX - (save.css.width / 2)
      top: oldCenterY - (save.css.height / 2)
      width: save.css.width
      height: save.css.height
    
    if op is 'rotate'
      graphic.dom.css
        width: save.css.height
        height: save.css.width