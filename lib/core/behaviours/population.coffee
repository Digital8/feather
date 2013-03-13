module.exports = (subject) ->
  
  subject.on 'add', ->
    subject.population = (Object.keys subject.objects).length
    if subject.population is 1
      subject.emit 'populate'
  
  subject.on 'remove', ->
    subject.population = (Object.keys subject.objects).length
    if subject.population is 0
      subject.emit 'unpopulate'