angular.module('loomioApp').directive 'tagDropdown', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_dropdown.html'
  controller: ($scope, TagRecordsInterface, Records, AbilityService) ->
    Records.addRecordsInterface(TagRecordsInterface) if !Records.tags
    Records.tags.fetchByGroup $scope.group.id

    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.group.id)

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup $scope.groupPage.group

    $scope.preventClose = (event) ->
      event.stopImmediatePropagation()

    $scope.toggleTagForm = (event) ->
      $scope.preventClose(event)
      $scope.showTagForm = !$scope.showTagForm

    $scope.$on 'closeTagForm', -> $scope.showTagForm = false

    return
