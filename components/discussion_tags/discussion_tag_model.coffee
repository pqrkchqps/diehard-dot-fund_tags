angular.module('loomioApp').factory 'DiscussionTagModel', (BaseModel) ->
  class DiscussionTagModel extends BaseModel
    @singular: 'discussionTag'
    @plural: 'discussionTags'
    @uniqueIndices: ['id']
    @indices: ['discussionId']
