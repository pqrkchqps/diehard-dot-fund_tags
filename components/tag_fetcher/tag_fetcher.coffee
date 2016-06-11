angular.module('loomioApp').directive 'tagFetcher', ->
  restrict: 'E'
  replace: true
  controller: ($scope, Records, DiscussionTagRecordsInterface) ->

    scopeModel = ->
      if $scope.discussion
        [$scope.discussion]
      else if $scope.query
        $scope.query.threads()

    Records.addRecordsInterface(DiscussionTagRecordsInterface) if !Records.discussionTags
    Records.discussionTags.fetch
      params:
        discussion_keys: _.pluck(scopeModel(), 'key')
