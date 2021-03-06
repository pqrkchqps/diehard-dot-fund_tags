module Plugins
  module DiehardFundTags
    class Plugin < Plugins::Base
      setup! 'diehard-dot-fund_tags' do |plugin|
        plugin.enabled = true

        plugin.use_database_table :tags do |table|
          table.belongs_to :group
          table.string :name
          table.string :color
          table.integer :discussion_tags_count, default: 0
          table.timestamps
        end

        plugin.use_database_table :discussion_tags do |table|
          table.belongs_to :tag
          table.belongs_to :discussion
          table.timestamps
        end
        plugin.use_class_directory 'models'

        plugin.use_factory :tag do
          group
          name "metatag"
          color "#656565"
        end

        plugin.use_factory :discussion_tag do
          discussion
          tag
        end

        plugin.extend_class Discussion do
          has_many :discussion_tags, dependent: :destroy
          has_many :tags, through: :discussion_tags
        end

        plugin.extend_class Group do
          has_many :tags
        end

        plugin.extend_class User do
          has_many :tags, through: :groups
        end

        plugin.extend_class PermittedParams do
          def discussion_tag
            params.require(:discussion_tag).permit(:tag_id, :discussion_id)
          end

          def tag
            params.require(:tag).permit(:name, :color, :group_id)
          end
        end

        plugin.extend_class API::DiscussionsController do
          module DiscussionsControllerTags
            def tags
              instantiate_collection do |collection|
                collection.sorted_by_latest_activity.joins(:discussion_tags)
                          .where('discussion_tags.tag_id': load_and_authorize(:tag).id)
              end
              respond_with_collection
            end

            private
            def default_scope
              super.merge(tag_cache: DiscussionTagCache.new(Array(resource || collection)).data)
            end
          end
          prepend DiscussionsControllerTags
        end

        plugin.extend_class BootData do
          module BootDataTags
            def serializer_scope
              super.merge(tag_cache: DiscussionTagCache.new(unread.to_a).data)
            end
          end
          prepend BootDataTags
        end

        plugin.extend_class DiscussionSerializer do
          has_many :discussion_tags

          def discussion_tags
            Array(Hash(scope).dig(:tag_cache, object.id))
          end
        end

        plugin.extend_class Ability do
          def add_additional_abilities
            can [:create, :destroy], DiscussionTag do |tag|
              if tag.group.members_can_edit_discussions?
                user_is_member_of?(tag.group_id)
              else
                user_is_author_of?(tag.discussion) or user_is_admin_of?(tag.group_id)
              end
            end

            can [:create, :update, :destroy], Tag do |tag|
              user_is_admin_of?(tag.group_id)
            end

            can :show, Tag do |tag|
              tag.group.is_visible_to_public? or
              user_is_member_of?(tag.group_id) or
              (tag.group.is_visible_to_parent_members? && user_is_member_of?(tag.group.parent_id))
            end
          end
        end

        plugin.extend_class LoggedOutUser do
          def tags
            Tag.none
          end
        end

        plugin.use_route :get,    '/tags/:id',                 'tags#show'
        plugin.use_route :get,    '/tags',                     'tags#index'
        plugin.use_route :post,   '/tags',                     'tags#create'
        plugin.use_route :patch,  '/tags/:id',                 'tags#update'
        plugin.use_route :delete, '/tags/:id',                 'tags#destroy'
        plugin.use_route :get,    '/discussions/tags/:tag_id', 'discussions#tags'
        plugin.use_route :post,   '/discussion_tags',          'discussion_tags#create'
        plugin.use_route :delete, '/discussion_tags/:id',      'discussion_tags#destroy'

        plugin.use_client_route   '/tags/:id', :tags_page
        plugin.use_client_route   '/tags/:id/:stub', :tags_page

        plugin.use_class 'controllers/tags_controller'
        plugin.use_class 'controllers/discussion_tags_controller'

        plugin.use_class 'services/tag_service'
        plugin.use_class 'services/discussion_tag_service'

        plugin.use_class 'serializers/tag_serializer'
        plugin.use_class 'serializers/discussion_tag_serializer'

        plugin.use_asset_directory 'components/models'
        plugin.use_asset_directory 'components/decorators'

        plugin.use_component :tag_display, outlet: [:after_thread_title, :after_thread_preview]
        plugin.use_component :tag_dropdown, outlet: [:before_thread_actions]
        plugin.use_component :tag_card, outlet: [:after_slack_card]
        plugin.use_component :tag_list
        plugin.use_component :tag_form
        plugin.use_component :tag_modal
        plugin.use_component :destroy_tag_modal

        plugin.use_test_route :setup_discussion_with_tag do
          tag = Tag.create(name: "Tag Name", color: "#cccccc", group: create_discussion.group)
          create_discussion.group.update(enable_experiments: true)
          sign_in patrick
          redirect_to discussion_url(create_discussion)
        end

        plugin.use_test_route :setup_inbox_with_tag do
          tag = Tag.create(name: "Tag Name", color: "#cccccc", group: create_discussion.group)
          discussion_tag = DiscussionTag.create(discussion: create_discussion, tag: tag)
          create_discussion.group.update(enable_experiments: true)
          sign_in patrick
          redirect_to inbox_url
        end

        plugin.use_test_route :view_discussion_as_visitor_with_tags do
          group = Group.create!(name: 'Open Dirty Dancing Shoes', group_privacy: 'open', enable_experiments: true)
          group.add_admin! patrick
          discussion = group.discussions.create!(title: 'This thread is public', private: false, author: patrick)
          tag = group.tags.create(name: "Tag Name", color: "#cccccc")
          discussion_tag = discussion.discussion_tags.create(tag: tag)
          redirect_to discussion_url(discussion)
        end

        plugin.use_test_route :visit_tags_page do
          group = Group.create!(name: 'Open Dirty Dancing Shoes', group_privacy: 'open', enable_experiments: true)
          group.add_admin! patrick
          discussion = group.discussions.create!(title: 'This thread is public', private: false, author: patrick)
          tag = group.tags.create(name: "Tag Name", color: "#cccccc")
          discussion_tag = discussion.discussion_tags.create(tag: tag)
          redirect_to "/tags/#{tag.id}"
        end

        plugin.use_translations 'config/locales', :diehard_fund_tags
      end
    end
  end
end
