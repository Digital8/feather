module.exports = (editor) ->
  
  editor.operations = operations = {}
  
  for key, type of require '../operations'
    
    operations[key] = new type
  
  editor.on 'graphic', (graphic) ->
    
    graphic.operate = (operation) ->
      
      graphic.operations.push operation
      
      graphic.emit 'operate'