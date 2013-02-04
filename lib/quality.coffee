module.exports = ->
  
  toolIndicator = jQuery '#indicator'
  
  captionHeading = jQuery '#indicator-heading'
  
  captionParagraph = jQuery '#indicator-paragraph'
  
  toolIndicatorAlert = jQuery '#indicator-alert'
  
  toolIndicator.removeClass('poor average').addClass 'perfect'
  captionHeading.html 'Perfect!'
  captionParagraph.html 'Your image is perfect for printing.'
  if box? && box != false then toolIndicatorAlert.fadeIn 150
  else toolIndicatorAlert.fadeOut 150