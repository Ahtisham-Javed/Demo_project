class Comment < ApplicationRecord
  validates :comment, presence: true, length: { in: 5..100 }
  validates :product_id, :user_id, presence: true, numericality: { only_integer: true }
  
  belongs_to :user
  belongs_to :product
end
