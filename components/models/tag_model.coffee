angular.module('loomioApp').factory 'TagModel', (BaseModel) ->
  class TagModel extends BaseModel
    @singular: 'tag'
    @plural: 'tags'
    @uniqueIndices: ['id']
    @indices: ['groupId']

    relationships: ->
      @belongsTo 'group'
