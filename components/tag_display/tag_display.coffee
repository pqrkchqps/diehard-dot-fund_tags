angular.module('loomioApp').directive 'tagDisplay', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_display.html'
  controller: ($scope, DiscussionTagRecordsInterface, Records) ->
    Records.addRecordsInterface(DiscussionTagRecordsInterface) if !Records.discussionTags
    $scope.tags = ->
      Records.discussionTags.find discussionId: ($scope.thread or $scope.threadPage.discussion).id

    return
