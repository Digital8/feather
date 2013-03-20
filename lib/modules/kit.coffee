Kit = require '../kit'

module.exports = (editor) ->
  
  editor.kit = kit = new Kit editor: editor
  
  for key, tool of (require '../tools')
    editor.kit.include tool
  
  editor.on 'ui', (key, tool) ->
    if key is 'tool'
      @kit.activate tool