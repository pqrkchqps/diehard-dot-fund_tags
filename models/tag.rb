class Tag < ActiveRecord::Base
  belongs_to :group, dependent: :destroy
  has_many :discussion_tags, dependent: :destroy
  has_many :discussions, through: :discussion_tags

  validates :group, presence: true
  validates :name, presence: true
  validates :color, presence: true
end
