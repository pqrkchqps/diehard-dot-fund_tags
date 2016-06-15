class ::API::DiscussionTagsController < API::RestfulController
  def index
    instantiate_collection { |collection| collection.joins(:tag).where('tags.group_id': params[:group_ids].to_s.split(',')) }
    respond_with_collection
  end

  private

  def accessible_records
    resource_class.joins(:discussion)
                  .includes(:tag)
                  .where('discussions.id': Queries::VisibleDiscussions.new(user: current_user).pluck(:id))
  end
end
