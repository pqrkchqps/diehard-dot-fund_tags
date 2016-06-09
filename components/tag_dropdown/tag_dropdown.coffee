angular.module('loomioApp').directive 'tagDropdown', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records) ->

    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.threadPage.discussion.groupId)

    return
