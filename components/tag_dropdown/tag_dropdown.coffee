angular.module('loomioApp').directive 'tagDropdown', ->
  scope: {discussion: '='}
  restrict: 'E'
  templateUrl: 'generated/components/tag_dropdown/tag_dropdown.html'
  controller: ($scope, Records, AbilityService, FormService) ->
    $scope.hasTags = ->
      _.any(Records.tags.find(groupId: $scope.discussion.group().parentOrSelf()))

    return
