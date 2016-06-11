class Tag < ActiveRecord::Base
  belongs_to :group
  has_many :discussion_tags, dependent: :destroy
  has_many :discussions, through: :discussion_tags

  validates :group, presence: true
  validates :name, presence: true
  validates :color, presence: true, format: /\A#([A-F0-9]{3}){1,2}\z/i
end
