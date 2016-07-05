angular.module('loomioApp').directive 'discussionTagDropdown', ->
  scope: {discussion: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/discussion_tag_dropdown/discussion_tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records, AbilityService, FormService) ->
    $scope.group = $scope.discussion.group().parentOrSelf()

    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup($scope.group)

    $scope.groupTags = ->
      groupId = $scope.group.id
      Records.tags.find(groupId: groupId)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: $scope.discussion.id, tagId: tagId)

    $scope.canAddTags = ->
      $scope.canAdministerGroup() or
      (AbilityService.canEditThread($scope.discussion) and _.any($scope.groupTags()))

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup $scope.group

    $scope.preventClose = (event) ->
      event.stopImmediatePropagation()

    $scope.toggleTagForm = (event) ->
      $scope.preventClose(event)
      $scope.showTagForm = !$scope.showTagForm

    $scope.editTag = (event, tag) ->
      $scope.currentTag = (tag or Records.tags.build(groupId: $scope.group.id, color: "#F6A82B")).clone()
      $scope.preventClose(event) if event
      $scope.showTagForm = !$scope.showTagForm

    $scope.$on 'closeTagForm', ->
      $scope.showTagForm = false

    return
