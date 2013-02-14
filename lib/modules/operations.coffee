# @operations = new Library
# for key, op of Operations
#   @operations.add op

module.exports = (editor) ->
  
  editor.operations = operations = {}
  
  for key, type of require '../operations'
    
    operations[key] = new type