angular.module('loomioApp').directive 'tagFetcher', ->
  restrict: 'E'
  replace: true
  controller: ($scope, Records, DiscussionTagRecordsInterface) ->

    Records.addRecordsInterface(DiscussionTagRecordsInterface) if !Records.discussionTags
    Records.discussionTags.fetch
      params:
        discussion_keys: _.pluck($scope.query.threads(), 'key')
