angular.module('diehardFundApp').factory 'TagModal', (Records) ->
  templateUrl: 'generated/components/tag_modal/tag_modal.html'
  controller: ($scope, tag) ->
    $scope.tag = tag.clone()
    $scope.$on 'closeTagForm', $scope.$close
