# canvas

```coffee
canvas = document.createElement 'canvas'
document.body.appendChild canvas
canvas.width = graphic.element.width()
canvas.height = graphic.element.height()
ctx = canvas.getContext '2d'

ctx.drawImage graphic.element.get(0), 0, 0
```