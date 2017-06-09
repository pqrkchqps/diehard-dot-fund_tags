describe 'discussion tags', ->
  page = require '../../../../angular/test/protractor/helpers/page_helper.coffee'

  describe 'creating a tag', ->
    it 'can create a tag for a group and a discussion', ->
      page.loadPath 'setup_experimental_group'
      page.click  '.discussion-tag-dropdown__button'
      page.click  '.discussion-tag-dropdown__label'
      page.fillIn '.tag-form__name', 'Tag Name'
      page.click  '.tag-form__submit'
      page.expectText '.discussion-tag-dropdown__list', 'Tag Name'

    it 'fetches tags when loading tags page', ->
      page.loadPath 'visit_tags_page'
      page.expectText '.thread-preview__text-container', 'This thread is public'

    it 'can create a discussion tag for a discussion', ->
      page.loadPath 'setup_discussion_with_tag'
      page.click '.discussion-tag-dropdown__button'
      page.click '.discussion-tag-dropdown__tag'
      page.expectText '.thread-tag', 'Tag Name'

    it 'serializes tags in the inbox', ->
      page.loadPath 'setup_inbox_with_tag'
      page.expectText '.thread-tag', 'Tag Name'

    it 'is visible to visitors', ->
      page.loadPath 'view_discussion_as_visitor_with_tags'
      page.expectText '.thread-tag', 'Tag Name'
