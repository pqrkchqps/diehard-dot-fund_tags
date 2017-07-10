angular.module('loomioApp').directive 'tagCard', ($location, Records, ModalService, TagModal, AbilityService, LoadingService) ->
  scope: {group: '='}
  templateUrl: 'generated/components/tag_card/tag_card.html'
  replace: true
  controller: ($scope) ->
    $scope.parent = $scope.group.parentOrSelf()

    $scope.init = ->
      Records.tags.fetchByGroup($scope.parent)
    LoadingService.applyLoadingFunction $scope, 'init'
    $scope.init()

    $scope.openTagForm = ->
      ModalService.open TagModal, tag: ->
        Records.tags.build(groupId: $scope.parent.id, color: "#F6A82B")

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup($scope.parent)

    $scope.$on 'editTag', (e, tag) ->
      ModalService.open TagModal, tag: -> tag
