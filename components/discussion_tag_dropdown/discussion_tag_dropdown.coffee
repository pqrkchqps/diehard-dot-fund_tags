angular.module('loomioApp').directive 'discussionTagDropdown', ->
  scope: {discussion: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/discussion_tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records, AbilityService, FormService) ->
    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup($scope.discussion.group())

    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.discussion.groupId)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: $scope.discussion.id, tagId: tagId)

    $scope.canEditThread = ->
      AbilityService.canEditThread $scope.discussion

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup $scope.discussion.group()

    $scope.preventClose = (event) ->
      event.stopImmediatePropagation()

    $scope.toggleTagForm = (event) ->
      $scope.preventClose(event)
      $scope.showTagForm = !$scope.showTagForm

    $scope.editTag = (event, tag) ->
      $scope.currentTag = (tag or Records.tags.build(groupId: $scope.discussion.groupId, color: "#999999")).clone()
      $scope.preventClose(event) if event
      $scope.showTagForm = !$scope.showTagForm

    $scope.$on 'closeTagForm', ->
      $scope.showTagForm = false

    return
