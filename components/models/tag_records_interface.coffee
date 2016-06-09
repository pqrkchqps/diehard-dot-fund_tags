angular.module('loomioApp').factory 'TagRecordsInterface', (BaseRecordsInterface, TagModel) ->
  class TagRecordsInterface extends BaseRecordsInterface
    model: TagModel

    fetchByGroup: (groupId) ->
      @fetch
        params:
          group_id: groupId
