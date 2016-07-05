angular.module('loomioApp').directive 'tagFetcher', ->
  scope: {discussion: '=?', group: '=?', query: '=?'}
  restrict: 'E'
  replace: true
  controller: ($scope, Records, Session, DiscussionTagRecordsInterface) ->

    $scope.groupIds = ->
      if $scope.query?
        _.uniq _.pluck($scope.query.threads(), 'groupId')
      else if $scope.discussion?
        [$scope.discussion.group().id]
      else if $scope.group?
        [$scope.group.parentOrSelf().id]
      else
        _.pluck Session.user().parentGroups(), 'id'

    Records.addRecordsInterface(DiscussionTagRecordsInterface) if !Records.discussionTags
    Records.discussionTags.fetch
      params:
        group_ids: $scope.groupIds().join(',')
