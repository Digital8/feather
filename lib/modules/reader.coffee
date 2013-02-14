# Reader = require './reader'

# reader ###

@reader = new Reader
@reader.on 'read', (dataURL) =>
  @image dataURL

# @reader = new FileReader

# @reader.addEventListener 'load', =>
#   @emit 'read', @reader.result

# @reader.readAsDataURL event.target.files[0]