module.exports = (rating) ->
  
  toolIndicator = jQuery '#indicator'
  
  captionHeading = jQuery '#indicator-heading'
  
  captionParagraph = jQuery '#indicator-paragraph'
  
  toolIndicatorAlert = jQuery '#indicator-alert'
  
  toolIndicator.removeClass 'poor average perfect'
  toolIndicator.addClass rating or 'perfect'
  
  captionHeading.html 'Perfect!'
  
  captionParagraph.html 'Your image is perfect for printing.'
  
  if box? && box != false then toolIndicatorAlert.fadeIn 150
  else toolIndicatorAlert.fadeOut 150