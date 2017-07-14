angular.module('diehard_fundApp').config ($provide) ->
  $provide.decorator 'LmoUrlService', ($delegate) ->
    $delegate.tag = (tag, params = {}, options = {}) ->
      @buildModelRoute('tags', tag.id, tag.name.toLowerCase(), params, options)
    $delegate
