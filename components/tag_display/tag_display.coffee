angular.module('loomioApp').directive 'tagDisplay', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_display.html'
  controller: ($scope, TagRecordsInterface, DiscussionTagRecordsInterface, Records) ->
    Records.addRecordsInterface(DiscussionTagRecordsInterface) unless Records.discussionTags
    Records.addRecordsInterface(TagRecordsInterface)           unless Records.tags

    $scope.tags = ->
      Records.discussionTags.find discussionId: ($scope.thread or $scope.threadPage.discussion).id

    return
