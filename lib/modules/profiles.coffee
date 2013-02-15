# Profile = require './profile'

# @profiles = new Library type: Profile
# for key, data of args.profiles
#   @profiles.new data

module.exports = (editor) ->
  
  (jQuery '#profile').change ->
    (jQuery '#tool-wall-art').show()