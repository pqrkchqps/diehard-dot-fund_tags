angular.module('loomioApp').factory 'TagRecordsInterface', (BaseRecordsInterface, TagModel) ->
  class TagRecordsInterface extends BaseRecordsInterface
    model: TagModel
