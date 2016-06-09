class DiscussionTag < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :tag
  has_one :group, through: :discussion
  delegate :group_id, to: :discussion

  validates :discussion, presence: true
  validates :tag, presence: true
end
