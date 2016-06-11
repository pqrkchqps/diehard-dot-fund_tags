angular.module('loomioApp').directive 'tagFetcher', ->
  scope: {discussion: '=?', query: '=?'}
  restrict: 'E'
  replace: true
  controller: ($scope, Records, DiscussionTagRecordsInterface) ->

    $scope.discussionKeys = ->
      if $scope.discussion?
        [$scope.discussion.key]
      else if $scope.query?
        _.pluck($scope.query.threads(), 'key')
      else
        []

    Records.addRecordsInterface(DiscussionTagRecordsInterface) if !Records.discussionTags
    Records.discussionTags.fetch
      params:
        discussion_keys: $scope.discussionKeys()
