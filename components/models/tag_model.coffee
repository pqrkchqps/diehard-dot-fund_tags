angular.module('loomioApp').factory 'TagModel', (BaseModel) ->
  class TagModel extends BaseModel
    @singular: 'tag'
    @plural: 'tags'
    @uniqueIndices: ['id']
    @indices: ['groupId']

    relationships: ->
      @belongsTo 'group'

    toggle: (discussionId) ->
      @discussionTagFor(discussionId).toggle()

    discussionTagFor: (discussionId) ->
      _.first(@recordStore.discussionTags.find(tagId: @id, discussionId: discussionId)) or
      @recordStore.discussionTags.build(tagId: @id, discussionId: discussionId)
