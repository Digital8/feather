Store = require './store'

module.exports = (subject) ->
  
  subject.filters = new Store
    default:
      saturation: 0
      sepia: 0
      contrast: 0
      lightness: 0
      temperature: 0
      focus: 0