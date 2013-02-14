jQuery?.fx?.speeds?.swift = 75

# @ui = {}
# @ui.stage = jQuery '#stage'

# args.ui ?= {}

# for key, selector of args.ui then do (key, selector) =>
#   element = jQuery selector
#   do (element) =>
#     element.click (event) =>
#       event.preventDefault()
      
#       @emit 'ui', key

# @on 'ui', (key) =>
#   console.log 'ui', key
  
#   if key in ['commit', 'reset']
#     @[key] null
#   else
#     @activate key

# @width = @ui.stage.width()
# @height = @ui.stage.height()

# @ui.stage.css width: @width
# @ui.stage.css height: @height

# @stage =
#   width: (jQuery '#tools').width()
#   height: (jQuery '#tools').height()
# @stage.aspect = @stage.width / @stage.height