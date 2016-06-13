angular.module('loomioApp').directive 'tagDropdown', ->
  scope: {group: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_dropdown/tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records, AbilityService) ->
    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup $scope.group

    $scope.hrefFor = (tag) ->
      ['tags', tag.id, tag.name].join('/')

    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.group.id)

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup $scope.group

    $scope.preventClose = (event) ->
      event.stopImmediatePropagation()

    $scope.editTag = (event, tag) ->
      $scope.currentTag = tag or Records.tags.build(groupId: $scope.group.id, color: "#F6A82B")
      $scope.preventClose(event) if event
      $scope.showTagForm = !$scope.showTagForm

    $scope.$on 'closeTagForm', ->
      $scope.editTag()

    return
