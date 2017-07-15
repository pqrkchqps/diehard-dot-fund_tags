angular.module('diehardFundApp').factory 'TagModel', (BaseModel) ->
  class TagModel extends BaseModel
    @singular: 'tag'
    @plural: 'tags'
    @uniqueIndices: ['id']
    @indices: ['groupId']
    @serializableAttributes: ['groupId', 'color', 'name']

    relationships: ->
      @belongsTo 'group'

    toggle: (discussionId) ->
      @discussionTagFor(discussionId).toggle()
      false

    discussionTagFor: (discussionId) ->
      _.first(@recordStore.discussionTags.find(tagId: @id, discussionId: discussionId)) or
      @recordStore.discussionTags.build(tagId: @id, discussionId: discussionId)
