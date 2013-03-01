Library = require '../../core/library'

Template = require './template'
Layout = require './layout'

module.exports = (editor, args) ->
  
  editor._templatesData = args.templates
  
  editor.templates = new Library type: Template, key: 'key'
  editor.layouts = new Library type: Layout, key: 'key'
  
  for key, templateData of args.templates then do (key, templateData) =>
    
    templateData.key = key
    
    templateData.editor = editor
    
    editor.templates.new templateData
  
  editor.editSlot = ({slot, layout}) ->
    
    editor.hideLayouts()
    editor.showTools()
    editor.showSurface()
    
    editor.surface.setSize slot.width * layout.width, slot.height * layout.height
  
  editor.editTemplate = ->
    
    editor.showLayouts()
    editor.hideTools()
    editor.hideSurface()
  
  (jQuery '#go_back').click (event) ->
    event.preventDefault()
    
    editor.editTemplate()