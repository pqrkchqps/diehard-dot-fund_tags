angular.module('diehard_fundApp').factory 'TagRecordsInterface', (BaseRecordsInterface, TagModel) ->
  class TagRecordsInterface extends BaseRecordsInterface
    model: TagModel

    fetchByGroup: (group) ->
      @fetch
        params:
          group_id: group.id
