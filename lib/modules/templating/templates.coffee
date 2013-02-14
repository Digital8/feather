# Templates = require './templates'

# ### templates ###
# @templates = new Library type: Template, key: 'key'

# @templates.on 'add', (template) =>
#   $a = jQuery """<a>#{template.key}</a>"""
#   $a.appendTo document.body
#   $a.click =>
#     @layouts.new template: template

# for key, data of args.templates
#   data.key = key
#   @templates.new data