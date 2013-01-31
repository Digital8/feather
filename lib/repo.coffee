{EventEmitter} = require 'events'

Queue = require './queue'
Library = require './library'

Base = require './base'

class Commit extends Base
  constructor: (args = {}) ->
    super

class Tag extends Base
  constructor: (args = {}) ->
    super

module.exports = class Repo extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @tags = new Library type: Tag
    
    @commits = new Library type: Commit
    
    @head = args.head
  
  cancel: ->
    console.log 'cancel'
    @emit 'cancel'
  
  undo: ->
    return unless head?
    
    @revert @head
    
    @emit 'undo'
  
  checkout: (commit) ->
    revert = ->
      unless @head is commit
        @revert @head
        
        revert()
    
    revert()
  
  revert: (commit) ->
    
    return unless commit?
    
    # commit.revert()
    console.log 'reverting...'
    
    @head = commit.back
    
    @emit 'revert'
  
  tag: (key) ->
    
    tag = @tags.new
      key: key
      head: @head
  
  commit: (diff) ->
    
    commit = @commits.new
      diff: diff
      back: @head
    
    @head = commit
    
    @emit 'commit', commit