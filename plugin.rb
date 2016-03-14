module Plugins
  module LoomioTags
    class Plugin < Plugins::Base
      setup! :loomio_tags do |plugin|
        plugin.enabled = true

        plugin.use_database_table :tags do |table|
          table.belongs_to :group
          table.string :name
          table.string :color
          table.timestamps
        end
        plugin.use_class 'models/tag'

        plugin.use_database_table :discussion_tags do |table|
          table.belongs_to :tag
          table.belongs_to :discussion
          table.timestamps
        end
        plugin.use_class 'models/discussion_tag'

        plugin.extend_class Discussion do
          has_many :discussion_tags, dependent: :destroy
          has_many :tags, through: :discussion_tags
        end

        plugin.extend_class Group do
          has_many :tags
        end

        plugin.use_route :get, '/discussion_tags', 'discussion_tags#index'
        plugin.use_class 'controllers/discussion_tags_controller'
        plugin.use_class 'serializers/discussion_tag_serializer'

        plugin.use_asset 'components/discussion_tags/discussion_tag_model.coffee'
        plugin.use_asset 'components/discussion_tags/discussion_tag_records_interface.coffee'
        plugin.use_component :tag_fetcher, outlet: [:before_thread_previews, :after_thread_title]
        plugin.use_component :tags, outlet: [:after_thread_title, :after_thread_preview]
      end
    end
  end
end
