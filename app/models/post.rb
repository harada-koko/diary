class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 280 }
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
