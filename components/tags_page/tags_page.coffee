angular.module('loomioApp').controller 'TagsPageController', ($rootScope, $routeParams, Records) ->
  $rootScope.$broadcast('currentComponent', { page: 'tagsPage'})
  Records.tags.findOrFetchById($routeParams.id).then (tag) =>
    @tag = tag

  return
