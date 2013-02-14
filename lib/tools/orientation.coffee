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
      selected = @editor.augmentations.get('select').selected
      
      return unless selected?
      
      graphic = selected
      
      graphic.scale[dimension] *= -1
      
      @_commit 'mirror', dimension
      
      return
    
    (jQuery '#orientation-vertical').click (event) =>
      event.preventDefault()
      mirror 1
    
    (jQuery '#orientation-horizontal').click (event) =>
      event.preventDefault()
      mirror 0
    
    @kit.editor.on 'graphic', (graphic) =>
      
      graphic.theta ?= 0
      graphic.scale ?= [1, 1]
        
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
    
    # if @kit.editor.augmentations.get('select').selected?
    #     @enable()
    # else
    #   @disable()
  
  deactivate: ->
    
    super
    
    # @disable()
  
  _commit: (op, args) ->
    if op is 'mirror'
      graphic = @editor.augmentations.get('select').selected
      
      operation = @editor.operations.get 'mirror'
      
      {url} = operation.operate graphic: graphic
      
      img = new Image
      document.body.appendChild img
      img.src = url
      
      graphic.image.src = url
    
    if op is 'rotate'
      graphic = @editor.augmentations.get('select').selected
      
      save = graphic.save()
      
      operation = @editor.operations.get 'rotate'
      
      {url, width, height} = operation.operate graphic: graphic
      
      previous = [save.css.left + (save.css.width / 2), save.css.top + (save.css.height / 2)]
      
      graphic.image.src = url
      
      graphic.dom.css
        left: previous[0] - (save.css.height / 2)
        top: previous[1] - (save.css.width / 2)
        width: save.css.height
        height: save.css.width