module.exports = (subject) ->
  
  subject.active = null
  
  subject.activate = (object) ->
    
    if object isnt @active
      
      @deactivate()
      
      @active = object
      
      if @active?.activate?
        @active.activate? null
      else if @active?.emit?
        @active.emit 'activate'
      
      @emit 'activate', object
  
  subject.deactivate = ->
    
    previous = @active
    
    if @active?.deactivate?
      @active?.deactivate? null
    else if @active?.emit?
      @active.emit 'deactivate'
    
    @active = null
    
    if previous?
      
      @emit 'deactivate', previous