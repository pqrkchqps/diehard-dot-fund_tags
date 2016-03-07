class DiscussionTagSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :color, :discussion_id

  def name
    tag.name
  end

  def color
    tag.color
  end

  private

  def tag
    @tag ||= object.tag
  end
end
