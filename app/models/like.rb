class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id, message: "You have already liked this post." }
end
