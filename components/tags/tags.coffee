angular.module('loomioApp').directive 'tags', ->
  restrict: 'E'
  replace: true
  templateUrl: 'generated/components/thread_tags.html'
  controller: ($scope) ->
