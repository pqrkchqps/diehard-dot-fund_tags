angular.module('diehard_fundApp').directive 'tagForm', (AppConfig, Records, ModalService, FormService, DestroyTagModal) ->
  scope: {tag: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_form/tag_form.html'
  controller: ($scope) ->
    $scope.tagColors = AppConfig.pluginConfig('diehard_fund_tags').config.colors

    $scope.closeForm = ->
      $scope.$emit 'closeTagForm'

    $scope.openDestroyForm = ->
      ModalService.open DestroyTagModal, tag: -> $scope.tag

    $scope.submit = FormService.submit $scope, $scope.tag,
      flashSuccess: 'diehard_fund_tags.tag_created'
      successCallback: $scope.closeForm

    return
