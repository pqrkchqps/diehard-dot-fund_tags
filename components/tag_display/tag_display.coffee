angular.module('diehardFundApp').directive 'tagDisplay', ->
  scope: {discussion: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_display/tag_display.html'
  controller: ($scope, Records) ->
    $scope.anyTags = ->
      _.any $scope.discussionTags()

    $scope.discussionTags = ->
      Records.discussionTags.find discussionId: $scope.discussion.id

    return
