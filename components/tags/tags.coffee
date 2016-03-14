angular.module('loomioApp').directive 'tags', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tags.html'
  controller: ($scope, Records) ->
    $scope.tags = ->
      Records.discussionTags.find(discussionId: $scope.thread.id)

    return
