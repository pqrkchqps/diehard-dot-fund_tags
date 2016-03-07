angular.module('loomioApp').directive 'tagFetcher', ->
  restrict: 'E'
  replace: true
  controller: ($scope, Records, MessageChannelService) ->
    updateTags = (data) ->
      _.each $scope.query.threads(), (thread) ->
        thread.update(tags: data[thread.key] or [])

    Records.discussions.remote.get('tags', discussion_keys: _.pluck($scope.query.threads(), 'key')).then updateTags
    # MessageChannelService.subscribeToGroup $scope.threadPage.discussion.group(), successFn: updateTags
