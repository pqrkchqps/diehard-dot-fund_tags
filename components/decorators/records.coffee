angular.module('diehardFundApp').config ($provide) ->
  $provide.decorator 'Records', ($delegate, DiscussionTagRecordsInterface, TagRecordsInterface) ->
    $delegate.addRecordsInterface(DiscussionTagRecordsInterface)
    $delegate.addRecordsInterface(TagRecordsInterface)
    $delegate
