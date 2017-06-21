angular.module('loomioApp').directive 'tagDropdown', ->
  scope: {group: '=?', discussion: '=?'}
  restrict: 'E'
  templateUrl: 'generated/components/tag_dropdown/tag_dropdown.html'
  controller: ($scope, Records, AbilityService, FormService) ->
    $scope.parent = ($scope.group or $scope.discussion.group()).parentOrSelf()
    Records.tags.fetchByGroup($scope.parent)

    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.parent.id)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: $scope.discussion.id, tagId: tagId)

    $scope.canAddTags = ->
      $scope.canAdministerGroup($scope.parent) or
      ($scope.discussion and AbilityService.canEditThread($scope.discussion) and _.any($scope.groupTags()))

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup $scope.parent

    $scope.editTag = (tag) ->
      tag = tag or Records.tags.build(groupId: $scope.parent.id, color: "#F6A82B")
      $scope.currentTag = tag.clone()

    $scope.$on 'closeTagForm', ->
      $scope.currentTag = null

    return
