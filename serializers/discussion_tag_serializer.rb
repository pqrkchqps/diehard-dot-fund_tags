class DiscussionTagSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :discussion_id
  has_one :tag, serializer: TagSerializer
end
