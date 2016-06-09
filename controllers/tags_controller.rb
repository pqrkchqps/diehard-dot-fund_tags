class ::API::TagsController < API::RestfulController
  def index
    instantiate_collection { |collection| collection.where(group: load_and_authorize(:group)) }
    respond_with_collection
  end

  private

  def accessible_records
    current_user.tags
  end
end
