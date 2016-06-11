class ::API::DiscussionTagsController < API::RestfulController
  def index
    instantiate_collection { |collection| collection.where('discussions.key': params[:discussion_keys].to_s.split(',')) }
    respond_with_collection
  end

  private

  def accessible_records
    resource_class.joins(:discussion)
                  .includes(:tag)
                  .where('discussions.id': Queries::VisibleDiscussions.new(user: current_user).pluck(:id))
  end
end
