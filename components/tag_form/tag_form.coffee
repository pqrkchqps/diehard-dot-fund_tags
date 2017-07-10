angular.module('loomioApp').directive 'tagForm', ->
  scope: {tag: '='}
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/tag_form/tag_form.html'
  controller: ($scope, Records, FormService) ->
    $scope.tagColors = [
      "#666666", "#802A2A", "#CE261B", "#F96168", "#F6A82B",
      "#00D374", "#00CDCD", "#337AB7", "#D966FF", "#CCCCCC"]

    $scope.closeForm = ->
      $scope.$emit 'closeTagForm'

    $scope.submit = FormService.submit $scope, $scope.tag,
      flashSuccess: 'loomio_tags.tag_created'
      successCallback: $scope.closeForm

    return
