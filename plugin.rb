module Plugins
  module LoomioTags
    class Plugin < Plugins::Base
      setup! :loomio_tags do |plugin|
        plugin.enabled = true

        plugin.use_database_table :tags do |table|
          table.belongs_to :group
          table.string :name
          table.string :color
          table.integer :discussion_tags_count, default: 0
          table.timestamps
        end
        plugin.use_class 'models/tag'

        plugin.use_database_table :discussion_tags do |table|
          table.belongs_to :tag
          table.belongs_to :discussion
          table.timestamps
        end
        plugin.use_class_directory 'models'

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

        plugin.use_route :get,    '/tags/:id',            'tags#show'
        plugin.use_route :get,    '/tags',                'tags#index'
        plugin.use_route :post,   '/tags',                'tags#create'
        plugin.use_route :patch,  '/tags/:id',            'tags#update'
        plugin.use_route :delete, '/tags/:id',            'tags#destroy'
        plugin.use_route :get,    '/discussion_tags',     'discussion_tags#index'
        plugin.use_route :post,   '/discussion_tags',     'discussion_tags#create'
        plugin.use_route :delete, '/discussion_tags/:id', 'discussion_tags#destroy'

        plugin.use_client_route   '/tags/:id', :tags_page
        plugin.use_client_route   '/tags/:id/:stub', :tags_page

        plugin.use_class 'controllers/tags_controller'
        plugin.use_class 'controllers/discussion_tags_controller'

        plugin.use_class 'services/tag_service'
        plugin.use_class 'services/discussion_tag_service'

        plugin.use_class 'serializers/tag_serializer'
        plugin.use_class 'serializers/discussion_tag_serializer'

        plugin.use_asset_directory 'components/models'
        plugin.use_component :tag_fetcher, outlet: [:before_thread_previews, :after_thread_title]
        plugin.use_component :tag_display, outlet: [:after_thread_title, :after_thread_preview]
        plugin.use_component :tag_dropdown, outlet: :before_group_actions
        plugin.use_component :discussion_tag_dropdown, outlet: :before_thread_actions
        plugin.use_component :tag_form

        plugin.use_translations 'config/locales', :loomio_tags
      end
    end
  end
end
