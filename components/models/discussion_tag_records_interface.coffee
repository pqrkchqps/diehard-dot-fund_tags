angular.module('diehardFundApp').factory 'DiscussionTagRecordsInterface', (BaseRecordsInterface, DiscussionTagModel) ->
  class DiscussionTagRecordsInterface extends BaseRecordsInterface
    model: DiscussionTagModel
