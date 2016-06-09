angular.module('loomioApp').directive 'tagDropdown', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records) ->
    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup $scope.threadPage.discussion.groupId

    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.threadPage.discussion.groupId)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: $scope.threadPage.discussion.id, tagId: tagId)

    return
