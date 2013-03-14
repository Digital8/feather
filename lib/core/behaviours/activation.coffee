module.exports = (subject) ->
  
  subject.active = null
  
  subject.activate = (object) ->
    
    if object isnt @active
      
      @deactivate()
      
      @active = object
      
      @active.activate? null
      
      @emit 'activate', object
  
  subject.deactivate = ->
    
    previous = @active
    
    @active?.deactivate? null
    
    @active = null
    
    if previous?
      
      @emit 'deactivate', previous