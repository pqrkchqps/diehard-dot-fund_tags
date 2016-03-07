class DiscussionTag < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :tag

  validates :discussion, presence: true
  validates :tag, presence: true
end
