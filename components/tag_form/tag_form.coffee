angular.module('loomioApp').directive 'tagForm', ->
  scope: {tag: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_form.html'
  controller: ($scope, FormService) ->
    $scope.tagColors = [
      "#000000", "#111111", "#222222",
      "#333333", "#444444", "#555555",
      "#666666", "#777777", "#888888",
      "#999999", "#aaaaaa", "#bbbbbb"]

    $scope.closeForm = -> $scope.$emit 'closeTagForm'

    $scope.submit = FormService.submit $scope, $scope.tag,
      flashSuccess: 'loomio_tags.tag_created'
      successCallback: $scope.closeForm

    $scope.delete = FormService.submit $scope, $scope.tag,
      submitFn: $scope.tag.destroy
      flashSuccess: 'loomio_tags.tag_destroyed'
      successCallback: $scope.closeForm

    return
