angular.module('diehardFundApp').directive 'tagList', (Records, FlashService, AbilityService)->
  scope: {group: '=?', discussion: '=?', admin: '='}
  restrict: 'E'
  templateUrl: 'generated/components/tag_list/tag_list.html'
  controller: ($scope) ->
    $scope.parent = ($scope.group or $scope.discussion.group()).parentOrSelf()
    Records.tags.fetchByGroup($scope.parent)

    $scope.groupTags = ->
      Records.tags.find(groupId: $scope.parent.id)

    $scope.tagSelected = (tagId) ->
      _.any Records.discussionTags.find(discussionId: $scope.discussion.id, tagId: tagId)

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup $scope.parent

    $scope.editTag = (tag) ->
      $scope.$emit 'editTag', tag
