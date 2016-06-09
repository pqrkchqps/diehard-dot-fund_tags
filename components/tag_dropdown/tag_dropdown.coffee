angular.module('loomioApp').directive 'tagDropdown', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records, AbilityService) ->
    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup $scope.threadPage.discussion.groupId

    discussion = $scope.threadPage.discussion
    $scope.tagColors = [
      "#000000", "#111111", "#222222",
      "#333333", "#444444", "#555555",
      "#666666", "#777777", "#888888",
      "#999999", "#aaaaaa", "#bbbbbb"]
    $scope.newTag = Records.tags.build(groupId: discussion.groupId, color: "#999999")

    $scope.groupTags = ->
      Records.tags.find(groupId: discussion.groupId)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: discussion.id, tagId: tagId)

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup discussion.group()

    $scope.preventClose = (event) ->
      event.stopImmediatePropagation()

    $scope.toggleTagForm = (event) ->
      $scope.preventClose(event)
      $scope.showTagForm = !$scope.showTagForm

    return
