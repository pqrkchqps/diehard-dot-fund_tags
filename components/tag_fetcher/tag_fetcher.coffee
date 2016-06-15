angular.module('loomioApp').directive 'tagFetcher', ->
  scope: {discussion: '=?', group: '=?'}
  restrict: 'E'
  replace: true
  controller: ($scope, Records, Session, DiscussionTagRecordsInterface) ->

    $scope.groupIds = ->
      if $scope.discussion?
        [$scope.discussion.group().key]
      else if $scope.group?
        [$scope.group.key]
      else
        _.pluck Session.user().parentGroups(), 'id'

    Records.addRecordsInterface(DiscussionTagRecordsInterface) if !Records.discussionTags
    Records.discussionTags.fetch
      params:
        group_ids: $scope.groupIds().join(',')
