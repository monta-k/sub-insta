class Like < ApplicationRecord

  belongs_to :post
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates :user_id, uniqueness: { scope: :post_id }

end
