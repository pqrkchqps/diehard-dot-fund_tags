angular.module('diehardFundApp').controller 'TagsPageController', ($rootScope, $routeParams, Records, ThreadQueryService) ->
  $rootScope.$broadcast('currentComponent', { page: 'tagsPage'})

  Records.discussions.fetch(path: "tags/#{$routeParams.id}")
  Records.tags.findOrFetchById($routeParams.id).then (tag) =>
    @tag = Records.tags.find(parseInt($routeParams.id))
    @view = ThreadQueryService.groupQuery @tag.group(), { filter: 'all', queryType: 'all' }

    # WARNING: hack because applyWhere doesn't seem to live update here.
    oldThreads = @view.threads
    @view.threads = =>
      _.filter oldThreads(), (thread) =>
        _.any Records.discussionTags.find(tagId: @tag.id, discussionId: thread.id)

  return
