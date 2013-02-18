module.exports = (editor) ->
  
  editor.handle = (event) ->
    
    reader = new FileReader
    
    reader.addEventListener 'load', =>
      editor.image src: reader.result
    
    reader.readAsDataURL event.target.files[0]