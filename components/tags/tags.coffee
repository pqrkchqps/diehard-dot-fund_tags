angular.module('loomioApp').directive 'tags', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tags.html'
  controller: ($scope, Records) ->
    $scope.anyTags = ->
      _.any $scope.tags()

    $scope.tags = ->
      Records.discussionTags.find
        discussionId: ($scope.thread or $scope.threadPage.discussion).id

    return
