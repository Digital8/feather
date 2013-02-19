module.exports = (editor, args) ->
  
  editor.templates = args.templates
  
  Layout = require './layout'
  
  for key, template of args.templates then do (key, template) =>
    
    $a = jQuery """<a>#{key}</a>"""
    $a.appendTo document.body
    $a.click =>
      
      layout = new Layout template: template, editor: editor
      layout.dom.appendTo editor.surface.element