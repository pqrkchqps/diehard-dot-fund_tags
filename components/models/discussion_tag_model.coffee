angular.module('diehard_fundApp').factory 'DiscussionTagModel', (BaseModel) ->
  class DiscussionTagModel extends BaseModel
    @singular: 'discussionTag'
    @plural: 'discussionTags'
    @uniqueIndices: ['id']
    @indices: ['discussionId']

    relationships: ->
      @belongsTo 'discussion'
      @belongsTo 'tag'

    toggle: ->
      if @isNew() then @save() else @destroy()
