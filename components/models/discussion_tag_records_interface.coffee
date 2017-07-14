angular.module('diehard_fundApp').factory 'DiscussionTagRecordsInterface', (BaseRecordsInterface, DiscussionTagModel) ->
  class DiscussionTagRecordsInterface extends BaseRecordsInterface
    model: DiscussionTagModel
