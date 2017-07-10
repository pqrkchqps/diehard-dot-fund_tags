angular.module('loomioApp').factory 'DestroyTagModal', (Records, FormService) ->
  templateUrl: 'generated/components/destroy_tag_modal/destroy_tag_modal.html'
  controller: ($scope, tag) ->
    $scope.tag = tag.clone()

    $scope.submit = FormService.submit $scope, $scope.tag,
      submitFn: $scope.tag.destroy
      flashSuccess: 'loomio_tags.tag_destroyed'
      successCallback: ->
        tag.remove()
        _.each Records.discussionTags.find(tagId: tag.id), (dtag) -> dtag.remove()
