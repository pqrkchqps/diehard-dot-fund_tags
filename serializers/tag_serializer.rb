class TagSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name, :color, :group_id
end
