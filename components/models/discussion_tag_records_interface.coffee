angular.module('loomioApp').factory 'DiscussionTagRecordsInterface', (BaseRecordsInterface, DiscussionTagModel) ->
  class DiscussionTagRecordsInterface extends BaseRecordsInterface
    model: DiscussionTagModel
