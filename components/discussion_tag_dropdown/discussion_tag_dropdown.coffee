angular.module('loomioApp').directive 'discussionTagDropdown', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/discussion_tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records, AbilityService, FormService) ->
    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup $scope.threadPage.discussion.groupId

    discussion = $scope.threadPage.discussion
    $scope.newTag = Records.tags.build(groupId: discussion.groupId, color: "#999999")

    $scope.groupTags = ->
      Records.tags.find(groupId: discussion.groupId)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: discussion.id, tagId: tagId)

    $scope.canEditThread = ->
      AbilityService.canEditThread discussion

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup discussion.group()

    $scope.preventClose = (event) ->
      event.stopImmediatePropagation()

    $scope.toggleTagForm = (event) ->
      $scope.preventClose(event)
      $scope.showTagForm = !$scope.showTagForm

    $scope.$on 'closeTagForm', -> $scope.showTagForm = false

    return
