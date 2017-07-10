angular.module('loomioApp').directive 'tagDropdown', ->
  scope: {discussion: '='}
  restrict: 'E'
  templateUrl: 'generated/components/tag_dropdown/tag_dropdown.html'
  controller: ($scope, Records, AbilityService, FormService) ->
    $scope.canAddTags = ->
      AbilityService.canAdministerGroup($scope.discussion.group().parentOrSelf()) or
      (AbilityService.canEditThread($scope.discussion) and _.any($scope.groupTags()))

    return
