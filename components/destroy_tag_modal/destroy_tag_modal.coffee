angular.module('diehardFundApp').factory 'DestroyTagModal', (Records, FormService) ->
  templateUrl: 'generated/components/destroy_tag_modal/destroy_tag_modal.html'
  controller: ($scope, tag) ->
    $scope.tag = Records.tags.find(tag.id)

    $scope.submit = FormService.submit $scope, $scope.tag,
      submitFn: $scope.tag.destroy
      flashSuccess: 'diehard_fund_tags.tag_destroyed'
      successCallback: ->
        $scope.tag.remove()
        _.each Records.discussionTags.find(tagId: tag.id), (dtag) -> dtag.remove()
